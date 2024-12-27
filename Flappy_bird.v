module Flappy_bird(output reg [7:0]DATA_R,DATA_G,DATA_B,output reg[3:0] COMM,//8x8led
input CLK,player1,restart,mode,//user input
output reg[1:0] com,output reg [3:0]A_count,output reg [3:0]A_count2,output reg a,b,c,d,e,f,g,//7 segment display 
output reg beep);//buzzer output

//initial posisi dari burung
reg [7:0] bird[7:0];
initial begin
bird[0]=8'b11111111;
bird[1]=8'b11111111;
bird[2]=8'b11111111;
bird[3]=8'b11111111;
bird[4]=8'b11111111;
bird[5]=8'b11111111;
bird[6]=8'b11101111;// bird=0
bird[7]=8'b11111111;
end

integer place=4;//track bird have horizomtal position

//pipe posisi awal 8x8 1=  pipa top, continue..
reg [7:0] pip_1[7:0];
initial begin
pip_1[0]=8'b00111000;
pip_1[1]=8'b00111000;
pip_1[2]=8'b11111111;
pip_1[3]=8'b11111111;
pip_1[4]=8'b11111111;
pip_1[5]=8'b11111111;
pip_1[6]=8'b11111111;
pip_1[7]=8'b11111111;
end
integer pip_place=0;////pipa gerak ke kanan

//adder patter pola adder pipa
reg [7:0]pip_2=8'b01110000;
reg [7:0]pip_3=8'b11100000;
reg [7:0]pip_4=8'b00001110;
reg [7:0]pip_5=8'b00000111;
reg [7:0]pip_6=8'b00011100;
reg [7:0]pip_7=8'b01111110;
reg [7:0]pip_8=8'b11001110;
reg [7:0]pip_9=8'b11111000;

integer pip_flag=0;//track pipa model yang didisplay

reg [2:0]cnt_r;
divfreq F0(CLK,CLK_div);//control kecepetan burung dan pip
divfreq2 F2(CLK,CLK_div2);//refresh led
divfreq3 F3(CLK,CLK_div3);//control game timer

//ii
initial 
begin
DATA_R=8'b11111111;
DATA_G=8'b11111111;
DATA_B=8'b11111111;
COMM=4'b100;
com=2'b01;
A_count <= 4'b0000;
A_count2 <= 4'b0000;
beep=1'b0;
end

//timerlogic
always @(posedge CLK_div3)
	if ((bird[6][place]==1'b0 && pip_1[6][place]==1'b0 && (~restart)))begin end //stop timer ketik burung nabrak pipa
	else if (A_count2==4'b0110 && restart)begin A_count <= 4'b0000; A_count2 <= 4'b0000; end  //kalo lebih dari 60 detik memang, tekan rest untuk reset
	else if (A_count2==4'b0110) begin end // ///timerny ga akan gerak kalau ga ipencet reset
	else begin
		if (restart) begin A_count <= 4'b0000; A_count2 <= 4'b0000;end //reset timer, kalo pencet restart
		else if (A_count==4'b1001) begin A_count<=4'b0000; A_count2<=A_count2+ 1'b1; end //bagian puluhan +1
		else A_count <= A_count + 1'b1; //satuan+1
	end	

always @(posedge CLK_div)
	begin 
		if (bird[6][place]==1'b0 && pip_1[6][place]==1'b0 && (~restart)) begin DATA_B=8'b10101010; beep=1'b1;end //kalau burungya nabrak pipa smeua jad biru
		else if (A_count2==4'b0110&& (~restart)) begin DATA_B=8'b00000000;end//60detik pass level
		else 
		begin
			beep=1'b0; //beep g bunyi
			DATA_B=8'b11111111;//screen biru keditek
			//restartsemua
			if (restart)begin
				place=4;
				pip_place=0;
				//pipa reset
				pip_1[0]=pip_3;
				pip_1[1]=pip_3;
				pip_1[2]=8'b11111111;
				pip_1[3]=8'b11111111;
				pip_1[4]=8'b11111111;
				pip_1[5]=8'b11111111;
				pip_1[6]=8'b11111111;
				pip_1[7]=8'b11111111;
				//burung reset
				bird[6]=8'b11101111;
				//timer rere

				if (mode)//tekn1 buat hardmode
				begin
					//hard
					pip_2=8'b00110000;
					pip_3=8'b01100000;
					pip_4=8'b11000011;
					pip_5=8'b00000011;
					pip_6=8'b00011000;
					pip_7=8'b11001100;
					pip_8=8'b10000110;
					pip_9=8'b10000001;
				end
			else
			begin 
			//simple
			pip_2=8'b01110000;
			pip_3=8'b11100000;
			pip_4=8'b00001110;
			pip_5=8'b00000111;
			pip_6=8'b00011100;
			pip_7=8'b01111110;
			pip_8=8'b00011110;
			pip_9=8'b11111000;
			end

			end
			if (player1)//kalau player1 dipecet
			begin
			if (place!=0)//kalau posisinya ga diatas,
				begin
					//posis burung  bakal naik
					bird[6][place]   = 1'b1;
					bird[6][place-1] = 1'b0;
					place=place-1;
				end
			end
			else	
			begin
				if (place!=7)//kalau posisi ga pling bwah 
				begin
					//burungnya turun
					bird[6][place]   = 1'b1;
					bird[6][place+1] = 1'b0;
					place=place+1;
				end
			end
			if (pip_place!=6)//kalau pipa ga ampe ending
				begin
				//pipa mobe backwo
					pip_1[pip_place+2]=pip_1[pip_place];
					pip_1[pip_place]=8'b11111111;
					pip_place=pip_place+1;
				end
			else 
			begin
				//delete pipa diakhir
				pip_1[6]=8'b11111111;
				pip_1[7]=8'b11111111;
				// types of pipe
				if (pip_flag==8) pip_flag=1;
				if(pip_flag==0)
				begin
					pip_1[0]=pip_2;
					pip_1[1]=pip_2;
				end
				if(pip_flag==1)
				begin
					pip_1[0]=pip_3;
					pip_1[1]=pip_3;
				end
				if(pip_flag==2)
				begin
					pip_1[0]=pip_4;
					pip_1[1]=pip_4;
				end
				if(pip_flag==3)
				begin
					pip_1[0]=pip_5;
					pip_1[1]=pip_5;
				end
				if(pip_flag==4)
				begin
					pip_1[0]=pip_6;
					pip_1[1]=pip_6;
				end
				if(pip_flag==5)
				begin
					pip_1[0]=pip_7;
					pip_1[1]=pip_7;
				end
				if(pip_flag==6)
				begin
					pip_1[0]=pip_8;
					pip_1[1]=pip_8;
				end
				if(pip_flag==7)
				begin
					pip_1[0]=pip_9;
					pip_1[1]=pip_9;
				end
				
				pip_flag=pip_flag+1;//pipa next style 
				pip_place=0;//pipa change bakc to 0
			end
		end
	end

always @(posedge CLK_div2)
	begin 
		com=~com;
		//LED display
		cnt_r<= cnt_r+1'b1; 
		COMM<={1'b1,cnt_r};
		if (cnt_r==3'b000)begin DATA_R<=bird[7];DATA_G<=pip_1[7]; end
		if (cnt_r==3'b001)begin DATA_R<=bird[6];DATA_G<=pip_1[6]; end
		if (cnt_r==3'b010)begin DATA_R<=bird[5];DATA_G<=pip_1[5]; end
		if (cnt_r==3'b011)begin DATA_R<=bird[4];DATA_G<=pip_1[4]; end
		if (cnt_r==3'b100)begin DATA_R<=bird[3];DATA_G<=pip_1[3]; end
		if (cnt_r==3'b101)begin DATA_R<=bird[2];DATA_G<=pip_1[2]; end
		if (cnt_r==3'b110)begin DATA_R<=bird[1];DATA_G<=pip_1[1]; end
		if (cnt_r==3'b111)begin DATA_R<=bird[0];DATA_G<=pip_1[0]; end
		//timerdisp
		if (com==2'b01)begin
			case ({A_count[3],A_count[2],A_count[1],A_count[0]})
			4'b0000:{a,b,c,d,e,f,g}=7'b0000001;
			4'b0001:{a,b,c,d,e,f,g}=7'b1001111;
			4'b0010:{a,b,c,d,e,f,g}=7'b0010010;
			4'b0011:{a,b,c,d,e,f,g}=7'b0000110;
			4'b0100:{a,b,c,d,e,f,g}=7'b1001100;
			4'b0101:{a,b,c,d,e,f,g}=7'b0100100;
			4'b0110:{a,b,c,d,e,f,g}=7'b0100000;
			4'b0111:{a,b,c,d,e,f,g}=7'b0001111;
			4'b1000:{a,b,c,d,e,f,g}=7'b0000000;
			4'b1001:{a,b,c,d,e,f,g}=7'b0000100;
			default:{a,b,c,d,e,f,g}=7'b1111111;
			endcase
		end
		else 
		begin
			case ({A_count2[3],A_count2[2],A_count2[1],A_count2[0]})
			4'b0000:{a,b,c,d,e,f,g}=7'b0000001;
			4'b0001:{a,b,c,d,e,f,g}=7'b1001111;
			4'b0010:{a,b,c,d,e,f,g}=7'b0010010;
			4'b0011:{a,b,c,d,e,f,g}=7'b0000110;
			4'b0100:{a,b,c,d,e,f,g}=7'b1001100;
			4'b0101:{a,b,c,d,e,f,g}=7'b0100100;
			4'b0110:{a,b,c,d,e,f,g}=7'b0100000;
			4'b0111:{a,b,c,d,e,f,g}=7'b0001111;
			4'b1000:{a,b,c,d,e,f,g}=7'b0000000;
			4'b1001:{a,b,c,d,e,f,g}=7'b0000100;
			default:{a,b,c,d,e,f,g}=7'b1111111;
			endcase
		end
end
endmodule


//burung, pipa movement speed
module divfreq(input clk,output reg clk_div);
 reg [24:0] count=25'b0;
 always @(posedge clk)
  begin
   if(count>25000000/2)//1sec2kali
    begin
     count <=25'b0;
     clk_div<=~clk_div;
    end
   else
    count<=count+1'b1;
  end
  
endmodule

//refresh rate
module divfreq2(input clk,output reg clk_div2);
 reg [24:0] count=25'b0;
 always @(posedge clk)
  begin
   if(count>25000)
    begin
     count <=25'b0;
     clk_div2<=~clk_div2;
    end
   else
    count<=count+1'b1;
  end
endmodule

//timer
module divfreq3(input CLK, output reg CLK_div3);
reg[24:0] Count =25'b0;
always @(posedge CLK)
	begin 
		if (Count>25000000)
			begin 
				Count <= 25'b0;
				CLK_div3 <= ~CLK_div3;
			end
		else 
			Count <= Count + 1'b1;
	end
endmodule

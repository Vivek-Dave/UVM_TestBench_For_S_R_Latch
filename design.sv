module sr(s,r,q,qbar);
	input s;
	input r;
	output reg q;
	output reg qbar;

	always@(*) begin 
		if(s==0 && r==0) begin 
			q    <=  q;
			qbar <= ~q;
		end
		else if(s==0 && r==1) begin 
			q    <=  0;
			qbar <= ~q;
		end
		else if(s==1 && r==0) begin 
			q    <=  1;
			qbar <= ~q;
		end
		else begin 
			q    <= 1'bx;
			qbar <= ~q;
		end
	end
endmodule : sr
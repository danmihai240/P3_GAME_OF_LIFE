/*

For a space that is 'populated':

Each cell with one or no neighbors dies, as if by solitude.             // (0 || 1) vecini => MORT
Each cell with four or more neighbors dies, as if by overpopulation.   // 4 vecini + => MORT
Each cell with two or three neighbors survives.                        // (2 || 3) vecini => VIU ( supravietuire )

For a space that is 'empty' or 'unpopulated'                           

Each cell with three neighbors becomes populated.   // fix 3 vecini => devine 1

*/

`define _Moarta   1'b0         // state 1 - celula moarta (0'b)
`define _Vie      1'b1         // state 2 - celula vie (1'b)

module automat(
	input rst,
	input clk,
	input seed,
	input [7:0] vecini,
	output reg alive
);
    reg state;
    wire[3:0]sum;

	 assign sum = vecini[0] + vecini[1] + vecini[2] + vecini[3] + vecini[4] + vecini[5] + vecini[6] + vecini[7];      // suma vecinilor
	
	always @(posedge clk)                  // pe frontul pozitiv al ceasului, actualizam starea celulei curente
		begin
		
		if (rst)                          // dacam dam reset, se incepe din nou
			 begin
			alive <= seed;                // vom vedea pe iesire, startul il dam noi (seed)
			state <= `_Moarta;           // state => _Mort
			end
		else
			begin                        // daca nu dam reset :
	
			case(state)
				`_Moarta:               // pentru cazul in care state-ul e 0'b
				begin
				if (sum==3)             // verificam daca suma e 3 ca sa actualizam starea celulei ( o facem vie )
					begin
					state<=`_Vie;          
					alive<=1;
					end
				
				else
					begin              // altfel ma duc in state de VIU sa verific daca ar putea sa fie 2
					state<=`_Vie;
					alive<=0;          // o initializam cu 0 ca sa veficam in case Viu stadiul celulei
					end	
				end
				
				`_Vie: 
				begin
				if (sum==2 || sum==3)           // daca e 2 sau 3
					begin
					state<=`_Vie;
					alive<=1;
					end 
				else
					begin
					state<=`_Moarta;
					alive<=0;
					end
				end	
			endcase	
			end
		end	
endmodule
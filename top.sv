module top
    (
    input clk,
    input rst,
    input  [63:0] seeds,
    output [7:0][7:0] cells 
    );
   wire [9:0][9:0] toate;
   genvar k;           // folosim pt loop uri (aceeasi operatie / instantiere de modul trebuie repetate de mai multe ori)
   genvar x;
   genvar i,j;  
    for(k=0; k<10;k=k+1) 
      begin
      assign toate[0][k]=0;
      assign toate[9][k]=0;
    end
   for(x=0;x<10;x=x+1)
   begin
    assign toate[x][0]=0;
   assign  toate[x][9]=0;
   end
   for (i = 1; i < 9; i = i+1) begin : nume1
            for (j = 1; j < 9; j = j+1) begin : nume2
                  assign  toate[i][j] = cells[i-1][j-1];
                    automat automat(
                        .clk(clk),
                        .rst(rst),
                        .seed(seeds[(i-1)*8+j-1]
                         ),  
                        .vecini({toate[i-1][j-1],
                               toate[i-1][j],
                               toate[i-1][j+1],
                               toate[i][j-1],
                               toate[i][j+1],
                               toate[i+1][j-1],
                               toate[i+1][j],
                               toate[i+1][j+1]                   
                                      }),
                        .alive(toate[i][j])
                    );
                end
        end
endmodule
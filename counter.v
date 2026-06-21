module counter(clk,
                reset,
                one_minute,
                new_current_time_ms_hr,
                new_current_time_ls_hr,
                new_current_time_ms_min,
                new_current_time_ls_hr,
                current_time_ms_hr,
                current_time_ls_hr,
                current_time_ms_min,
                current_time_ls_min,
                load_new_c,
                );
    
    input [3:0] new_current_time_ms_hr,
                new_current_time_ls_hr,
                new_current_time_ms_min,
                new_current_time_ls_hr;
    input clk, reset, one_minute, load_new_c;

    output [3:0] current_time_ms_hr,
                 current_time_ls_hr,
                 current_time_ms_min,
                 current_time_ls_min;

    reg [3:0]  current_time_ms_hr,
               current_time_ls_hr,
               current_time_ms_min,
               current_time_ls_min;

    always@(posedge clk or posedge reset)begin
        if(reset)begin
            current_time_ms_hr <= 0;
            current_time_ls_hr <= 0;
            current_time_ms_min <=0;
            current_time_ls_min <=0;
        end
        else if(load_new_c)begin
            current_time_ms_hr <= new_current_time_ms_hr;
            current_time_ls_hr <= new_current_time_ls_hr;
            current_time_ms_min <=new_current_time_ms_min;
            current_time_ls_min <=new_current_time_ls_min;
        end
        else if(one_minute == 1)begin
            // if current time os 23:59, then the next current_time will be 00:00
            if(current_time_ms_hr == 4'd2 && current_time_ms_min == 4'd5 && current_time_ls_hr == 4'd3 && current_time_ls_min == 4'd9)
            begin
                current_time_ms_hr <= 0;
                current_time_ls_hr <= 0;
                current_time_ms_min <=0;
                current_time_ls_min <=0;
            end
            // if the time represented by is x9:59 the next time ms_hr will increment
            else if (current_time_ls_hr = 4'd9 && current_time_ms_min = 4'd5 && current_time_ms_min = 4'd9)
            begin
                current_time_ms_hr <= current_time_ms_hr+1'b1;
                current_time_ls_hr <= 0;
                current_time_ms_min <=0;
                current_time_ls_min <=0;
            end
            // if the time represented by is xx:59 then ls_her will be incrementate
            else if (current_time_ms_min == 4'd5 && current_time_ls_min == 4'd9)
            begin
                current_time_ls_hr <= current_time_ls_hr+1'b1;
                current_time_ms_min <=0;
                current_time_ls_min <=0;
            end
            else if (current_time_ls_min == 4'd9)
            begin
                current_time_ms_min <= current_time_ms_min + 1'b1;
                current_time_ls_min <= 4'd0;
            end
            else
            begin
                current_time_ls_min <= current_time_ls_min + 1'b1;
            end
        end
    end        
endmodule 
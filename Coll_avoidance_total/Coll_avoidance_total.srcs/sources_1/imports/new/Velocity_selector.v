module Velocity_selector(x_real,y_real,clock,active,x_rot,y_rot,vs_done);
    
    input  [15:0]x_real;
    input  [15:0]y_real;
    input  clock;
    input  active;
    output [15:0]x_rot;
    output [15:0]y_rot;
    output vs_done;
    
    wire [15:0]theta_real;
    wire [15:0]mag_real;
    wire [15:0]mag;
    wire [15:0]phase;
    reg rtp_in_rdy,ptr_in_rdy;
    wire rtp_out_rdy,ptr_out_rdy;
    reg  [15:0]mag1;
    reg  [15:0]phase1;
    wire [15:0] x_real_nm,y_real_nm,x_rot_nm,y_rot_nm;
    reg  [15:0]step=16'd164;
    reg  [15:0]stepphase=16'd6430;
    reg  done=1'b0;
    reg [15:0] x_rot_reg,y_rot_reg;
    integer count=-1;
    Rect_to_polar RP(x_real_nm,y_real_nm,mag,phase,rtp_in_rdy,rtp_out_rdy);
    Polar_to_rect PR(mag_real,theta_real,x_rot_nm,y_rot_nm,ptr_in_rdy,ptr_out_rdy);
    
    assign vs_done=done;
    assign mag_real=mag1;
    assign theta_real=phase1;
    
    assign x_real_nm =(x_real<<3);       //To make it compatible with overall Fixed point representation
    assign y_real_nm =(y_real<<3);
    assign x_rot     =x_rot_reg;
    assign y_rot     =y_rot_reg;
    real x_rot_real,y_rot_real;

    always @(posedge active)
    begin
    rtp_in_rdy =1'b1;
    end
    
    
    always @(posedge rtp_out_rdy)
    begin
        #10;
        mag1=mag;
        phase1=phase;
        rtp_in_rdy =1'b0;
        mag1=mag1-step;
        if(mag1<16'd3277)
        begin
            phase1=phase1-stepphase;
            mag1=16'd16384;
        end
        ptr_in_rdy=1'b1;
    end
    
    always @(posedge ptr_out_rdy)
    begin
        #10;
        ptr_in_rdy=1'b0;
     end   
     always @(x_rot_nm or y_rot_nm)
     begin
         if(ptr_out_rdy==1'b1)
         begin
             x_rot_real=$signed(x_rot_nm)*(1.0/((2**14)*1.0));//For signed conditions, converting it to real and then to binary should be done rather than shifting
             y_rot_real=$signed(y_rot_nm)*(1.0/((2**14)*1.0));
             x_rot_reg=x_rot_real*(2**11);
             y_rot_reg=y_rot_real*(2**11);
             done=1'b1;
             #10;
             done=1'b0;
         end
     end
endmodule
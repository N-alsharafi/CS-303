`default_nettype none

module main
(
    input clk,
    input uart_rx,
    output uart_tx,
    output reg [5:0] led,
    input btn1,
    input btn2
);

reg [3:0] s [7:0];
reg [7:0] leds;

wire [7:0] switches;
wire [7:0] buttons;
wire [4:0] keypad;
wire btn1d;
wire [3:0] t10;
wire [3:0] t1;

uart uart1(clk, uart_rx, uart_tx, switches, buttons, keypad, {leds, s[7],s[6],s[5],s[4],s[3],s[2],t10,t1});
tally tly1(clk, btn2, btn1d, t10, t1); 
debounce db1(clk, btn1, btn1d);

reg prevKeyPressed = 0;
wire keyPressed;

initial begin
    s[0] = 4'b0000;
    s[1] = 4'b0000;
    s[2] = 4'b0000;
    s[3] = 4'b0000;
    s[4] = 4'b0000;
    s[5] = 4'b0000;
    s[6] = 4'b0000;
    s[7] = 4'b0000;
    leds = 8'b10101010;
end

always @(posedge clk) begin
	led <= ~switches[5:0];
end

endmodule

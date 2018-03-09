module fft_8pt(
    clk,
    reset_n,
    valid_in,
    valid_out,
    xi0_re,
    xi1_re,
    xi2_re,
    xi3_re,
    xi4_re,
    xi5_re,
    xi6_re,
    xi7_re,
    xo0_re,
    xo1_re,
    xo2_re,
    xo3_re,
    xo4_re,
    xo5_re,
    xo6_re,
    xo7_re,
    xi0_im,
    xi1_im,
    xi2_im,
    xi3_im,
    xi4_im,
    xi5_im,
    xi6_im,
    xi7_im,
    xo0_im,
    xo1_im,
    xo2_im,
    xo3_im,
    xo4_im,
    xo5_im,
    xo6_im,
    xo7_im,
    W0_8_re, W1_8_re, W2_8_re, W3_8_re, W0_8_im, W1_8_im, W2_8_im, W3_8_im
);

parameter szBit = 17;

input  clk;
input  reset_n;
input  valid_in;
output valid_out;

reg valid_in_d1r, valid_in_d2r;
reg signed [63:0] out_tmp_d1r, out_tmp_d2r, out_tmp_d3r;

input  signed [63:0]  xi0_re;
input  signed [63:0]  xi1_re;
input  signed [63:0]  xi2_re;
input  signed [63:0]  xi3_re;
input  signed [63:0]  xi4_re;
input  signed [63:0]  xi5_re;
input  signed [63:0]  xi6_re;
input  signed [63:0]  xi7_re;
input  signed [63:0]  xi0_im;
input  signed [63:0]  xi1_im;
input  signed [63:0]  xi2_im;
input  signed [63:0]  xi3_im;
input  signed [63:0]  xi4_im;
input  signed [63:0]  xi5_im;
input  signed [63:0]  xi6_im;
input  signed [63:0]  xi7_im;

input  signed [63:0]  W0_8_re;
input  signed [63:0]  W1_8_re;
input  signed [63:0]  W2_8_re;
input  signed [63:0]  W3_8_re;
input  signed [63:0]  W0_8_im;
input  signed [63:0]  W1_8_im;
input  signed [63:0]  W2_8_im;
input  signed [63:0]  W3_8_im;

output signed [63:0]  xo0_re;
output signed [63:0]  xo1_re;
output signed [63:0]  xo2_re;
output signed [63:0]  xo3_re;
output signed [63:0]  xo4_re;
output signed [63:0]  xo5_re;
output signed [63:0]  xo6_re;
output signed [63:0]  xo7_re;
output signed [63:0]  xo0_im;
output signed [63:0]  xo1_im;
output signed [63:0]  xo2_im;
output signed [63:0]  xo3_im;
output signed [63:0]  xo4_im;
output signed [63:0]  xo5_im;
output signed [63:0]  xo6_im;
output signed [63:0]  xo7_im;

reg   signed [64-1:0]  xo0_re_w_d1r, xo0_re_w_d2r;
reg   signed [64-1:0]  xo1_re_w_d1r, xo1_re_w_d2r;
reg   signed [64-1:0]  xo2_re_w_d1r, xo2_re_w_d2r;
reg   signed [64-1:0]  xo3_re_w_d1r, xo3_re_w_d2r;
reg   signed [64-1:0]  xo4_re_w_d1r, xo4_re_w_d2r;
reg   signed [64-1:0]  xo5_re_w_d1r, xo5_re_w_d2r;
reg   signed [64-1:0]  xo6_re_w_d1r, xo6_re_w_d2r;
reg   signed [64-1:0]  xo7_re_w_d1r, xo7_re_w_d2r;
reg   signed [64-1:0]  xo0_im_w_d1r, xo0_im_w_d2r;
reg   signed [64-1:0]  xo1_im_w_d1r, xo1_im_w_d2r;
reg   signed [64-1:0]  xo2_im_w_d1r, xo2_im_w_d2r;
reg   signed [64-1:0]  xo3_im_w_d1r, xo3_im_w_d2r;
reg   signed [64-1:0]  xo4_im_w_d1r, xo4_im_w_d2r;
reg   signed [64-1:0]  xo5_im_w_d1r, xo5_im_w_d2r;
reg   signed [64-1:0]  xo6_im_w_d1r, xo6_im_w_d2r;
reg   signed [64-1:0]  xo7_im_w_d1r, xo7_im_w_d2r;

wire  signed [64-1:0]  W0_8_re_w = {W0_8_re[63:63-szBit+1], {(64-szBit){1'b0}}};
wire  signed [64-1:0]  W1_8_re_w = {W1_8_re[63:63-szBit+1], {(64-szBit){1'b0}}};
wire  signed [64-1:0]  W2_8_re_w = {W2_8_re[63:63-szBit+1], {(64-szBit){1'b0}}};
wire  signed [64-1:0]  W3_8_re_w = {W3_8_re[63:63-szBit+1], {(64-szBit){1'b0}}};
wire  signed [64-1:0]  W0_8_im_w = {W0_8_im[63:63-szBit+1], {(64-szBit){1'b0}}};
wire  signed [64-1:0]  W1_8_im_w = {W1_8_im[63:63-szBit+1], {(64-szBit){1'b0}}};
wire  signed [64-1:0]  W2_8_im_w = {W2_8_im[63:63-szBit+1], {(64-szBit){1'b0}}};
wire  signed [64-1:0]  W3_8_im_w = {W3_8_im[63:63-szBit+1], {(64-szBit){1'b0}}};

wire   signed [64-1:0]  xi0_re_w = {xi0_re[63:63-szBit+1], {(64-szBit){1'b0}}};
wire   signed [64-1:0]  xi1_re_w = {xi1_re[63:63-szBit+1], {(64-szBit){1'b0}}};
wire   signed [64-1:0]  xi2_re_w = {xi2_re[63:63-szBit+1], {(64-szBit){1'b0}}};
wire   signed [64-1:0]  xi3_re_w = {xi3_re[63:63-szBit+1], {(64-szBit){1'b0}}};
wire   signed [64-1:0]  xi4_re_w = {xi4_re[63:63-szBit+1], {(64-szBit){1'b0}}};
wire   signed [64-1:0]  xi5_re_w = {xi5_re[63:63-szBit+1], {(64-szBit){1'b0}}};
wire   signed [64-1:0]  xi6_re_w = {xi6_re[63:63-szBit+1], {(64-szBit){1'b0}}};
wire   signed [64-1:0]  xi7_re_w = {xi7_re[63:63-szBit+1], {(64-szBit){1'b0}}};
wire   signed [64-1:0]  xi0_im_w = {xi0_im[63:63-szBit+1], {(64-szBit){1'b0}}};
wire   signed [64-1:0]  xi1_im_w = {xi1_im[63:63-szBit+1], {(64-szBit){1'b0}}};
wire   signed [64-1:0]  xi2_im_w = {xi2_im[63:63-szBit+1], {(64-szBit){1'b0}}};
wire   signed [64-1:0]  xi3_im_w = {xi3_im[63:63-szBit+1], {(64-szBit){1'b0}}};
wire   signed [64-1:0]  xi4_im_w = {xi4_im[63:63-szBit+1], {(64-szBit){1'b0}}};
wire   signed [64-1:0]  xi5_im_w = {xi5_im[63:63-szBit+1], {(64-szBit){1'b0}}};
wire   signed [64-1:0]  xi6_im_w = {xi6_im[63:63-szBit+1], {(64-szBit){1'b0}}};
wire   signed [64-1:0]  xi7_im_w = {xi7_im[63:63-szBit+1], {(64-szBit){1'b0}}};

wire   signed [64-1:0]  xo0_re_w;
wire   signed [64-1:0]  xo1_re_w;
wire   signed [64-1:0]  xo2_re_w;
wire   signed [64-1:0]  xo3_re_w;
wire   signed [64-1:0]  xo4_re_w;
wire   signed [64-1:0]  xo5_re_w;
wire   signed [64-1:0]  xo6_re_w;
wire   signed [64-1:0]  xo7_re_w;
wire   signed [64-1:0]  xo0_im_w;
wire   signed [64-1:0]  xo1_im_w;
wire   signed [64-1:0]  xo2_im_w;
wire   signed [64-1:0]  xo3_im_w;
wire   signed [64-1:0]  xo4_im_w;
wire   signed [64-1:0]  xo5_im_w;
wire   signed [64-1:0]  xo6_im_w;
wire   signed [64-1:0]  xo7_im_w;


wire    signed [64-1:0]  s1_0_re;
wire    signed [64-1:0]  s1_1_re;
wire    signed [64-1:0]  s1_2_re;
wire    signed [64-1:0]  s1_3_re;
wire    signed [64-1:0]  s1_4_re;
wire    signed [64-1:0]  s1_5_re;
wire    signed [64-1:0]  s1_6_re;
wire    signed [64-1:0]  s1_7_re;

wire    signed [64-1:0]  s1_0_im;
wire    signed [64-1:0]  s1_1_im;
wire    signed [64-1:0]  s1_2_im;
wire    signed [64-1:0]  s1_3_im;
wire    signed [64-1:0]  s1_4_im;
wire    signed [64-1:0]  s1_5_im;
wire    signed [64-1:0]  s1_6_im;
wire    signed [64-1:0]  s1_7_im;

wire    signed [64-1:0]  s2_0_re;
wire    signed [64-1:0]  s2_1_re;
wire    signed [64-1:0]  s2_2_re;
wire    signed [64-1:0]  s2_3_re;
wire    signed [64-1:0]  s2_4_re;
wire    signed [64-1:0]  s2_5_re;
wire    signed [64-1:0]  s2_6_re;
wire    signed [64-1:0]  s2_7_re;

wire    signed [64-1:0]  s2_0_im;
wire    signed [64-1:0]  s2_1_im;
wire    signed [64-1:0]  s2_2_im;
wire    signed [64-1:0]  s2_3_im;
wire    signed [64-1:0]  s2_4_im;
wire    signed [64-1:0]  s2_5_im;
wire    signed [64-1:0]  s2_6_im;
wire    signed [64-1:0]  s2_7_im;

wire    signed [64-1:0]  s3_0_re;
wire    signed [64-1:0]  s3_1_re;
wire    signed [64-1:0]  s3_2_re;
wire    signed [64-1:0]  s3_3_re;
wire    signed [64-1:0]  s3_4_re;
wire    signed [64-1:0]  s3_5_re;
wire    signed [64-1:0]  s3_6_re;
wire    signed [64-1:0]  s3_7_re;

wire    signed [64-1:0]  s3_0_im;
wire    signed [64-1:0]  s3_1_im;
wire    signed [64-1:0]  s3_2_im;
wire    signed [64-1:0]  s3_3_im;
wire    signed [64-1:0]  s3_4_im;
wire    signed [64-1:0]  s3_5_im;
wire    signed [64-1:0]  s3_6_im;
wire    signed [64-1:0]  s3_7_im;

wire    signed [64-1:0]  s1_4_tmp_re;
wire    signed [64-1:0]  s1_6_tmp_re;
wire    signed [64-1:0]  s1_5_tmp_re;
wire    signed [64-1:0]  s1_7_tmp_re;
wire    signed [64-1:0]  s1_4_tmp_im;
wire    signed [64-1:0]  s1_6_tmp_im;
wire    signed [64-1:0]  s1_5_tmp_im;
wire    signed [64-1:0]  s1_7_tmp_im;

wire    signed [64-1:0]   s2_2_tmp_re;
wire    signed [64-1:0]   s2_3_tmp_re;
wire    signed [64-1:0]   s2_6_tmp_re;
wire    signed [64-1:0]   s2_7_tmp_re;
wire    signed [64-1:0]   s2_2_tmp_im;
wire    signed [64-1:0]   s2_3_tmp_im;
wire    signed [64-1:0]   s2_6_tmp_im;
wire    signed [64-1:0]   s2_7_tmp_im;

wire    signed [64-1:0]   s3_1_tmp_re;
wire    signed [64-1:0]   s3_3_tmp_re;
wire    signed [64-1:0]   s3_5_tmp_re;
wire    signed [64-1:0]   s3_7_tmp_re;
wire    signed [64-1:0]   s3_1_tmp_im;
wire    signed [64-1:0]   s3_3_tmp_im;
wire    signed [64-1:0]   s3_5_tmp_im;
wire    signed [64-1:0]   s3_7_tmp_im;

//------------- Stage 1 ----------------
wire   signed [64-1:0]  xi0_re_tmp = (xi0_re_w>>>0)<<<0;
wire   signed [64-1:0]  xi1_re_tmp = (xi1_re_w>>>0)<<<0;
wire   signed [64-1:0]  xi2_re_tmp = (xi2_re_w>>>0)<<<0;
wire   signed [64-1:0]  xi3_re_tmp = (xi3_re_w>>>0)<<<0;
wire   signed [64-1:0]  xi4_re_tmp = (xi4_re_w>>>0)<<<0;
wire   signed [64-1:0]  xi5_re_tmp = (xi5_re_w>>>0)<<<0;
wire   signed [64-1:0]  xi6_re_tmp = (xi6_re_w>>>0)<<<0;
wire   signed [64-1:0]  xi7_re_tmp = (xi7_re_w>>>0)<<<0;
wire   signed [64-1:0]  xi0_im_tmp = (xi0_im_w>>>0)<<<0;
wire   signed [64-1:0]  xi1_im_tmp = (xi1_im_w>>>0)<<<0;
wire   signed [64-1:0]  xi2_im_tmp = (xi2_im_w>>>0)<<<0;
wire   signed [64-1:0]  xi3_im_tmp = (xi3_im_w>>>0)<<<0;
wire   signed [64-1:0]  xi4_im_tmp = (xi4_im_w>>>0)<<<0;
wire   signed [64-1:0]  xi5_im_tmp = (xi5_im_w>>>0)<<<0;
wire   signed [64-1:0]  xi6_im_tmp = (xi6_im_w>>>0)<<<0;
wire   signed [64-1:0]  xi7_im_tmp = (xi7_im_w>>>0)<<<0;

wire    signed [64-1:0]  W0_8_re_tmp = (W0_8_re_w>>>0);
wire    signed [64-1:0]  W1_8_re_tmp = (W1_8_re_w>>>0);
wire    signed [64-1:0]  W2_8_re_tmp = (W2_8_re_w>>>0);
wire    signed [64-1:0]  W3_8_re_tmp = (W3_8_re_w>>>0);
wire    signed [64-1:0]  W0_8_im_tmp = (W0_8_im_w>>>0);
wire    signed [64-1:0]  W1_8_im_tmp = (W1_8_im_w>>>0);
wire    signed [64-1:0]  W2_8_im_tmp = (W2_8_im_w>>>0);
wire    signed [64-1:0]  W3_8_im_tmp = (W3_8_im_w>>>0);

assign valid_out = valid_in_d2r;


always_ff @(negedge reset_n or posedge clk) begin
    if(!reset_n) begin
        valid_in_d1r <= 0;
        valid_in_d2r <= 0;
        xo0_re_w_d1r<=0; xo0_im_w_d1r<=0;
        xo1_re_w_d1r<=0; xo1_im_w_d1r<=0;
        xo2_re_w_d1r<=0; xo2_im_w_d1r<=0;
        xo3_re_w_d1r<=0; xo3_im_w_d1r<=0;
        xo4_re_w_d1r<=0; xo4_im_w_d1r<=0;
        xo5_re_w_d1r<=0; xo5_im_w_d1r<=0;
        xo6_re_w_d1r<=0; xo6_im_w_d1r<=0;
        xo7_re_w_d1r<=0; xo7_im_w_d1r<=0;
        xo0_re_w_d2r<=0; xo0_im_w_d2r<=0;
        xo1_re_w_d2r<=0; xo1_im_w_d2r<=0;
        xo2_re_w_d2r<=0; xo2_im_w_d2r<=0;
        xo3_re_w_d2r<=0; xo3_im_w_d2r<=0;
        xo4_re_w_d2r<=0; xo4_im_w_d2r<=0;
        xo5_re_w_d2r<=0; xo5_im_w_d2r<=0;
        xo6_re_w_d2r<=0; xo6_im_w_d2r<=0;
        xo7_re_w_d2r<=0; xo7_im_w_d2r<=0;

    end else begin
        valid_in_d1r <= valid_in;
        valid_in_d2r <= valid_in_d1r;
        xo0_re_w_d1r<=xo0_re_w; xo0_im_w_d1r<=xo0_im_w;
        xo1_re_w_d1r<=xo1_re_w; xo1_im_w_d1r<=xo1_im_w;
        xo2_re_w_d1r<=xo2_re_w; xo2_im_w_d1r<=xo2_im_w;
        xo3_re_w_d1r<=xo3_re_w; xo3_im_w_d1r<=xo3_im_w;
        xo4_re_w_d1r<=xo4_re_w; xo4_im_w_d1r<=xo4_im_w;
        xo5_re_w_d1r<=xo5_re_w; xo5_im_w_d1r<=xo5_im_w;
        xo6_re_w_d1r<=xo6_re_w; xo6_im_w_d1r<=xo6_im_w;
        xo7_re_w_d1r<=xo7_re_w; xo7_im_w_d1r<=xo7_im_w;
        xo0_re_w_d2r<=xo0_re_w_d1r; xo0_im_w_d2r<=xo0_im_w_d1r;
        xo1_re_w_d2r<=xo1_re_w_d1r; xo1_im_w_d2r<=xo1_im_w_d1r;
        xo2_re_w_d2r<=xo2_re_w_d1r; xo2_im_w_d2r<=xo2_im_w_d1r;
        xo3_re_w_d2r<=xo3_re_w_d1r; xo3_im_w_d2r<=xo3_im_w_d1r;
        xo4_re_w_d2r<=xo4_re_w_d1r; xo4_im_w_d2r<=xo4_im_w_d1r;
        xo5_re_w_d2r<=xo5_re_w_d1r; xo5_im_w_d2r<=xo5_im_w_d1r;
        xo6_re_w_d2r<=xo6_re_w_d1r; xo6_im_w_d2r<=xo6_im_w_d1r;
        xo7_re_w_d2r<=xo7_re_w_d1r; xo7_im_w_d2r<=xo7_im_w_d1r;
    end
end

assign s1_0_re = (xi0_re_tmp>>>0)+(xi4_re_tmp>>>0);
assign s1_1_re = (xi1_re_tmp>>>0)+(xi5_re_tmp>>>0);
assign s1_2_re = (xi2_re_tmp>>>0)+(xi6_re_tmp>>>0);
assign s1_3_re = (xi3_re_tmp>>>0)+(xi7_re_tmp>>>0);
assign s1_4_re = (xi0_re_tmp>>>0)-(xi4_re_tmp>>>0);
assign s1_5_re = (xi1_re_tmp>>>0)-(xi5_re_tmp>>>0);
assign s1_6_re = (xi2_re_tmp>>>0)-(xi6_re_tmp>>>0);
assign s1_7_re = (xi3_re_tmp>>>0)-(xi7_re_tmp>>>0);

assign s1_0_im = (xi0_im_tmp>>>0)+(xi4_im_tmp>>>0);
assign s1_1_im = (xi1_im_tmp>>>0)+(xi5_im_tmp>>>0);
assign s1_2_im = (xi2_im_tmp>>>0)+(xi6_im_tmp>>>0);
assign s1_3_im = (xi3_im_tmp>>>0)+(xi7_im_tmp>>>0);
assign s1_4_im = (xi0_im_tmp>>>0)-(xi4_im_tmp>>>0);
assign s1_5_im = (xi1_im_tmp>>>0)-(xi5_im_tmp>>>0);
assign s1_6_im = (xi2_im_tmp>>>0)-(xi6_im_tmp>>>0);
assign s1_7_im = (xi3_im_tmp>>>0)-(xi7_im_tmp>>>0);

assign s1_4_tmp_re = real_part(s1_4_re, s1_4_im, (W0_8_re_tmp>>>0), (W0_8_im_tmp>>>0) );
assign s1_5_tmp_re = real_part(s1_5_re, s1_5_im, (W1_8_re_tmp>>>0), (W1_8_im_tmp>>>0) );
assign s1_6_tmp_re = real_part(s1_6_re, s1_6_im, (W2_8_re_tmp>>>0), (W2_8_im_tmp>>>0) );
assign s1_7_tmp_re = real_part(s1_7_re, s1_7_im, (W3_8_re_tmp>>>0), (W3_8_im_tmp>>>0) );
assign s1_4_tmp_im = imag_part(s1_4_re, s1_4_im, (W0_8_re_tmp>>>0), (W0_8_im_tmp>>>0) );
assign s1_5_tmp_im = imag_part(s1_5_re, s1_5_im, (W1_8_re_tmp>>>0), (W1_8_im_tmp>>>0) );
assign s1_6_tmp_im = imag_part(s1_6_re, s1_6_im, (W2_8_re_tmp>>>0), (W2_8_im_tmp>>>0) );
assign s1_7_tmp_im = imag_part(s1_7_re, s1_7_im, (W3_8_re_tmp>>>0), (W3_8_im_tmp>>>0) );

//------------- Stage 2 ----------------
assign s2_0_re = s1_0_re + s1_2_re;
assign s2_1_re = s1_1_re + s1_3_re;
assign s2_2_re = s1_0_re - s1_2_re;
assign s2_3_re = s1_1_re - s1_3_re;
assign s2_4_re = s1_4_tmp_re + s1_6_tmp_re;
assign s2_5_re = s1_5_tmp_re + s1_7_tmp_re;
assign s2_6_re = s1_4_tmp_re - s1_6_tmp_re;
assign s2_7_re = s1_5_tmp_re - s1_7_tmp_re;

assign s2_0_im = s1_0_im + s1_2_im;
assign s2_1_im = s1_1_im + s1_3_im;
assign s2_2_im = s1_0_im - s1_2_im;
assign s2_3_im = s1_1_im - s1_3_im;
assign s2_4_im = s1_4_tmp_im + s1_6_tmp_im;
assign s2_5_im = s1_5_tmp_im + s1_7_tmp_im;
assign s2_6_im = s1_4_tmp_im - s1_6_tmp_im;
assign s2_7_im = s1_5_tmp_im - s1_7_tmp_im;

assign s2_2_tmp_re = real_part(s2_2_re, s2_2_im, W0_8_re, W0_8_im);
assign s2_3_tmp_re = real_part(s2_3_re, s2_3_im, W2_8_re, W2_8_im);
assign s2_6_tmp_re = real_part(s2_6_re, s2_6_im, W0_8_re, W0_8_im);
assign s2_7_tmp_re = real_part(s2_7_re, s2_7_im, W2_8_re, W2_8_im);
assign s2_2_tmp_im = imag_part(s2_2_re, s2_2_im, W0_8_re, W0_8_im);
assign s2_3_tmp_im = imag_part(s2_3_re, s2_3_im, W2_8_re, W2_8_im);
assign s2_6_tmp_im = imag_part(s2_6_re, s2_6_im, W0_8_re, W0_8_im);
assign s2_7_tmp_im = imag_part(s2_7_re, s2_7_im, W2_8_re, W2_8_im);

//------------- Stage 3 ----------------
assign s3_0_re = s2_0_re + s2_1_re;
assign s3_1_re = s2_0_re - s2_1_re;
assign s3_2_re = s2_2_tmp_re + s2_3_tmp_re;
assign s3_3_re = s2_2_tmp_re - s2_3_tmp_re;
assign s3_4_re = s2_4_re + s2_5_re;
assign s3_5_re = s2_4_re - s2_5_re;
assign s3_6_re = s2_6_tmp_re + s2_7_tmp_re;
assign s3_7_re = s2_6_tmp_re - s2_7_tmp_re;

assign s3_0_im = s2_0_im + s2_1_im;
assign s3_1_im = s2_0_im - s2_1_im;
assign s3_2_im = s2_2_tmp_im + s2_3_tmp_im;
assign s3_3_im = s2_2_tmp_im - s2_3_tmp_im;
assign s3_4_im = s2_4_im + s2_5_im;
assign s3_5_im = s2_4_im - s2_5_im;
assign s3_6_im = s2_6_tmp_im + s2_7_tmp_im;
assign s3_7_im = s2_6_tmp_im - s2_7_tmp_im;

assign s3_1_tmp_re = real_part(s3_1_re, s3_1_im, W0_8_re, W0_8_im);
assign s3_3_tmp_re = real_part(s3_3_re, s3_3_im, W0_8_re, W0_8_im);
assign s3_5_tmp_re = real_part(s3_5_re, s3_5_im, W0_8_re, W0_8_im);
assign s3_7_tmp_re = real_part(s3_7_re, s3_7_im, W0_8_re, W0_8_im);
assign s3_1_tmp_im = imag_part(s3_1_re, s3_1_im, W0_8_re, W0_8_im);
assign s3_3_tmp_im = imag_part(s3_3_re, s3_3_im, W0_8_re, W0_8_im);
assign s3_5_tmp_im = imag_part(s3_5_re, s3_5_im, W0_8_re, W0_8_im);
assign s3_7_tmp_im = imag_part(s3_7_re, s3_7_im, W0_8_re, W0_8_im);

//------------- Output Stage ----------------
assign xo0_re_w = s3_0_re ;
assign xo1_re_w = s3_1_tmp_re ;
assign xo2_re_w = s3_2_re ;
assign xo3_re_w = s3_3_tmp_re ;
assign xo4_re_w = s3_4_re ;
assign xo5_re_w = s3_5_tmp_re ;
assign xo6_re_w = s3_6_re ;
assign xo7_re_w = s3_7_tmp_re ;
assign xo0_im_w = s3_0_im ;
assign xo1_im_w = s3_1_tmp_im ;
assign xo2_im_w = s3_2_im ;
assign xo3_im_w = s3_3_tmp_im ;
assign xo4_im_w = s3_4_im ;
assign xo5_im_w = s3_5_tmp_im ;
assign xo6_im_w = s3_6_im ;
assign xo7_im_w = s3_7_tmp_im ;

//assign xo0_re={xo0_re_w_d2r[63:63-szBit+1], {(64-szBit){1'b0}}};
//assign xo1_re={xo1_re_w_d2r[63:63-szBit+1], {(64-szBit){1'b0}}};
//assign xo2_re={xo2_re_w_d2r[63:63-szBit+1], {(64-szBit){1'b0}}};
//assign xo3_re={xo3_re_w_d2r[63:63-szBit+1], {(64-szBit){1'b0}}};
//assign xo4_re={xo4_re_w_d2r[63:63-szBit+1], {(64-szBit){1'b0}}};
//assign xo5_re={xo5_re_w_d2r[63:63-szBit+1], {(64-szBit){1'b0}}};
//assign xo6_re={xo6_re_w_d2r[63:63-szBit+1], {(64-szBit){1'b0}}};
//assign xo7_re={xo7_re_w_d2r[63:63-szBit+1], {(64-szBit){1'b0}}};
//assign xo0_im={xo0_im_w_d2r[63:63-szBit+1], {(64-szBit){1'b0}}};
//assign xo1_im={xo1_im_w_d2r[63:63-szBit+1], {(64-szBit){1'b0}}};
//assign xo2_im={xo2_im_w_d2r[63:63-szBit+1], {(64-szBit){1'b0}}};
//assign xo3_im={xo3_im_w_d2r[63:63-szBit+1], {(64-szBit){1'b0}}};
//assign xo4_im={xo4_im_w_d2r[63:63-szBit+1], {(64-szBit){1'b0}}};
//assign xo5_im={xo5_im_w_d2r[63:63-szBit+1], {(64-szBit){1'b0}}};
//assign xo6_im={xo6_im_w_d2r[63:63-szBit+1], {(64-szBit){1'b0}}};
//assign xo7_im={xo7_im_w_d2r[63:63-szBit+1], {(64-szBit){1'b0}}};

assign xo0_re={xo0_re_w_d2r[63:63-szBit+1], {(64-szBit){1'b0}}};
assign xo1_re={xo1_re_w_d2r[63:63-szBit+1], {(64-szBit){1'b0}}};
assign xo2_re={xo2_re_w_d2r[63:63-szBit+1], {(64-szBit){1'b0}}};
assign xo3_re={xo3_re_w_d2r[63:63-szBit+1], {(64-szBit){1'b0}}};
assign xo4_re={xo4_re_w_d2r[63:63-szBit+1], {(64-szBit){1'b0}}};
assign xo5_re={xo5_re_w_d2r[63:63-szBit+1], {(64-szBit){1'b0}}};
assign xo6_re={xo6_re_w_d2r[63:63-szBit+1], {(64-szBit){1'b0}}};
assign xo7_re={xo7_re_w_d2r[63:63-szBit+1], {(64-szBit){1'b0}}};
assign xo0_im={xo0_im_w_d2r[63:63-szBit+1], {(64-szBit){1'b0}}};
assign xo1_im={xo1_im_w_d2r[63:63-szBit+1], {(64-szBit){1'b0}}};
assign xo2_im={xo2_im_w_d2r[63:63-szBit+1], {(64-szBit){1'b0}}};
assign xo3_im={xo3_im_w_d2r[63:63-szBit+1], {(64-szBit){1'b0}}};
assign xo4_im={xo4_im_w_d2r[63:63-szBit+1], {(64-szBit){1'b0}}};
assign xo5_im={xo5_im_w_d2r[63:63-szBit+1], {(64-szBit){1'b0}}};
assign xo6_im={xo6_im_w_d2r[63:63-szBit+1], {(64-szBit){1'b0}}};
assign xo7_im={xo7_im_w_d2r[63:63-szBit+1], {(64-szBit){1'b0}}};


//-------------------------------------------------
// Input format:
// real_part(a,b,c,d);
// imag_part(a,b,c,d);
//-------------------------------------------------
// real_part = (ac-bd)
// imag_part = (ad+bc)
//-------------------------------------------------
function signed [64-1:0] real_part;
    input   signed [64-1:0]  a;
    input   signed [64-1:0]  b;
    input   signed [64-1:0]  c;
    input   signed [64-1:0]  d;
    reg     signed [64*2-1:0] real_part_tmp;
    reg     signed [64*2-1:0] tmp1;
    reg     signed [64*2-1:0] tmp2;
    reg     signed [64*2-1:0] tmp3;
    reg     signed [64-1:0] a_tmp;
    reg     signed [64-1:0] b_tmp;
    reg     signed [64-1:0] c_tmp;
    reg     signed [64-1:0] d_tmp;
    begin
        a_tmp = {a[63:63-szBit+1], {(64-szBit){1'b0}}};
        b_tmp = {b[63:63-szBit+1], {(64-szBit){1'b0}}};
        c_tmp = {c[63:63-szBit+1], {(64-szBit){1'b0}}};
        d_tmp = {d[63:63-szBit+1], {(64-szBit){1'b0}}};
        tmp1 = a_tmp*c_tmp;
        tmp2 = b_tmp*d_tmp;
        tmp3 = tmp1 - tmp2;
        real_part_tmp = tmp3 >>> (64-4);
        real_part = real_part_tmp[64-1:0];
    end
endfunction

function signed [64-1:0] imag_part;
    input   signed [64-1:0]  a;
    input   signed [64-1:0]  b;
    input   signed [64-1:0]  c;
    input   signed [64-1:0]  d;
    reg     signed [64*2-1:0] imag_part_tmp;
    reg     signed [64*2-1:0] tmp1;
    reg     signed [64*2-1:0] tmp2;
    reg     signed [64*2-1:0] tmp3;
    reg     signed [64-1:0] a_tmp;
    reg     signed [64-1:0] b_tmp;
    reg     signed [64-1:0] c_tmp;
    reg     signed [64-1:0] d_tmp;
    begin
        a_tmp = {a[63:63-szBit+1], {(64-szBit){1'b0}}};
        b_tmp = {b[63:63-szBit+1], {(64-szBit){1'b0}}};
        c_tmp = {c[63:63-szBit+1], {(64-szBit){1'b0}}};
        d_tmp = {d[63:63-szBit+1], {(64-szBit){1'b0}}};
        tmp1 = a_tmp*d_tmp;
        tmp2 = b_tmp*c_tmp;
        tmp3 = tmp1 + tmp2;
        imag_part_tmp = tmp3 >>> (64-4);
        imag_part = imag_part_tmp[64-1:0];
    end
endfunction

endmodule


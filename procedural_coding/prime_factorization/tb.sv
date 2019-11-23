
module tb ;

initial begin
int num,try_factor;
int factors[$];
num = 45;
try_factor = 2;
factorize(num,try_factor,factors);
$finish;
end

function automatic void factorize ( 
ref int num,
ref int try_factor,
ref int factors[$]
);

if ( num == 1 ) begin
	factors.push_back(1);
	return;
end else begin
	if ( num % try_factor == 0 )  begin
		num = num / try_factor ;
		factors.push_back(try_factor);
		try_factor=2;
	end else begin
		try_factor++;
	end
end

endfunction

endmodule

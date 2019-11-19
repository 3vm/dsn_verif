
module tb ;

class  list_c ;
	int elem;
	list_c prev;
endclass

list_c prev_elem=new();
list_c this_elem;
list_c last_elem;

initial begin
	for(int i = 0;i<5;i++) begin
		this_elem = new();
		this_elem.elem = i;
		this_elem.prev = prev_elem;
		prev_elem = this_elem;
	end
	last_elem = this_elem;

	this_elem = last_elem;
	for(int i= 0 ; i<5;i++) begin
		$display("List element at node %d value %d" , i, this_elem.elem );
		this_elem = this_elem.prev;
	end
end

endmodule

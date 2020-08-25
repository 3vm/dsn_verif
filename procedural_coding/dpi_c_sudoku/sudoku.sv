

parameter size= 3;
parameter ssq =size*size;

typedef byte sud_options_t [ssq][ssq][ssq];
typedef byte sud_puzzle_t [ssq][ssq];

program tb;

    byte rp[ssq][ssq],cp[ssq][ssq],bp[ssq][ssq];
    byte i,j,k,l,flag,rowstart,colstart,boxno;
    byte prob[ssq][ssq][ssq];
    int in_num;
    byte s[ssq][ssq]='{     
                '{0,1,0,8,9,0,4,0,0},
                '{6,0,0,0,5,4,0,0,3},
                '{4,2,0,0,0,6,7,0,0},
                '{7,0,0,4,0,0,0,3,8},
                '{0,9,2,0,0,0,5,4,0},
                '{3,6,0,0,0,1,0,0,9},
                '{0,0,8,1,0,0,0,2,6},
                '{1,0,0,9,3,0,0,0,7},
                '{0,0,5,0,7,8,0,1,0}   
 };
initial begin
    $write("\nThe 9 by 9 sudoku matrix to be solved\n");
    show_sud(s);

    for(i=0;i<=ssq-1;i++)
    begin
        for(j=1;j<=ssq;j++)
        begin
            //row probables
            rp[i][j-1]=1;
            for(k=0;k<=ssq-1;k++)
            begin
                if(s[i][k]==j)
                begin
                    rp[i][j-1]=0;
                    break;
                end
            end

            //column probables
            cp[i][j-1]=1;
            for(k=0;k<=ssq-1;k++)
            begin
                if(s[k][i]==j)
                begin
                    cp[i][j-1]=0;
                    break;
                end
            end
        end

        //box probables
        rowstart=(i/size)*size;
        colstart=(i%size)*size;
        for(j=1;j<=ssq;j++)
        begin
            bp[i][j-1]=1;
            for(k=0;k<=size-1;k++)
            begin
                for(l=0;l<=size-1;l++)
                begin
                    if(s[rowstart+k][colstart+l]==j)
                    begin
                        bp[i][j-1]=0;
                        l=size;k=size;//goto out2loops;
                    end
                end
            end
            //out2loops: ;
        end
    end

    for(i=0;i<=ssq-1;i++)
    begin
        for(j=0;j<=ssq-1;j++)
        begin
            boxno=(i/size)*size+(j/size);
            flag=1;
            if(s[i][j])
            begin
                flag=0;
            end
            for(k=0;k<=ssq-1;k++)
            begin
                prob[k][i][j]=(rp[i][k])&&(cp[j][k])&&(bp[boxno][k])&&flag;
            end
        end
    end
    sud(prob, s, 0, 0);
end
endprogram

function automatic void sud( 
    input sud_options_t fnp,
    input sud_puzzle_t fns, input byte c, input byte d) ;
    byte i,j,k,i0,j0,rowstart,colstart,boxno;
    sud_puzzle_t temp;
    bit out2loops=0;

    if((c==ssq)&&(d==ssq))
    begin
        $write("\n C %d and d %d\n",c,d);
        $write("\n The solution is\n");
        show_sud(fns);
        return;
    end
 
    $display("C %d and d %d\n",c,d);
    
    show_sud(fns);

    //find the vacant square
    for(i=c;i<=ssq-1 && out2loops==0;i++)
    begin
        if(i!=c)
        begin
            d=0;
        end
        for(j=d;j<=ssq-1;j++)
        begin
            $display("Test [%d][%d]",i,j);
            if(fns[i][j]==0)
            begin
                $display("Found vacant [%d][%d]",i,j);
                out2loops=1 ; //goto out;
                i0=i;
                j0=j;
                break;
            end
        end
    end
    //out:
    if(out2loops==0) begin
        i0=i;
        j0=j;
    end

    $display("Vacant square [%d][%d]",i,j);
    if((i0==ssq)&&(j0==ssq))
    begin
        $display("\nThe solution is");
        show_sud(fns);
        return;
    end

    //find the probable number to fill up the vacant square
    for(k=0;k<=ssq-1;k++)
    begin
        if(fnp[k][i0][j0]==1)
        begin
            for(i=0;i<=ssq-1;i++)
            begin
                for(j=0;j<=ssq-1;j++)
                begin
                    temp[i][j]=fnp[k][i][j];
                end
            end
            fns[i0][j0]=k+1;
            boxno=(i0/size)*size+(j0/size);
            rowstart=(boxno/size)*size;
            colstart=(boxno%size)*size;
            for(i=0;i<=size-1;i++)
            begin
                for(j=0;j<=size-1;j++)
                begin
                    fnp[k][rowstart+i][colstart+j]=0;
                end
            end
            for(i=0;i<=ssq-1;i++)
            begin
                fnp[k][i][j0]=0;
                fnp[k][i0][i]=0;
            end

            c=i0;
            d=j0+1;
            if(j0==ssq-1)
            begin
                if(i0==ssq-1)
                begin
                    c=ssq;
                    d=ssq;
                end
                else
                begin
                    c=i0+1;
                    d=0;
                end
            end
            $display("Call next box [%d][%d]",c,d);
            sud(fnp,fns,c,d);
            $display("later");
            for(i=0;i<=ssq-1;i++)
            begin
                for(j=0;j<=ssq-1;j++)
                begin
                    fnp[k][i][j]=temp[i][j];
                end
            end
        end
    end
endfunction

function automatic void show_sud (sud_puzzle_t s);
    for(int i=0;i<=ssq-1;i++)
    begin
        for(int j=0;j<=ssq-1;j++)
        begin
            $write("%1d ",s[i][j]);
        end
        $write("\n");
    end
    $write("\n");
endfunction


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
    $write("\nenter the numbers in the 9 by 9 sudoku matrix as shown in the following example\n");
    for(int i=0;i<=ssq-1;i++) begin
    
        for(int j=0;j<=ssq-1;j++) begin
            $write("%d ",s[i][j]);
        end
        $write("\n");
    end
    $write("\n");
/*
    for(int i=0;i<=ssq-1;i++)
    begin
        for(int j=0;j<=ssq-1;j++)
        begin
            scanf("%d",&in_num);
            s[i][j] = (byte ) in_num ;
        end
    end
    //clrscr();
    $write("\nThis is the one you entered\n");
    for(int i=0;i<=ssq-1;i++)
    begin
        for(int j=0;j<=ssq-1;j++)
        begin
            $write("%d ",s[i][j]);
        end
        $write("\n");
    end
*/
    $write("\n\n");

    for(int i=0;i<=ssq-1;i++)
    begin
        for(int j=1;j<=ssq;j++)
        begin
            //row probables
            rp[i][j-1]=1;
            for(int k=0;k<=ssq-1;k++)
            begin
                if(s[i][k]==j)
                begin
                    rp[i][j-1]=0;
                    break;
                end
            end

            //column probables
            cp[i][j-1]=1;
            for(int k=0;k<=ssq-1;k++)
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
        for(int j=1;j<=ssq;j++)
        begin
            bp[i][j-1]=1;
            for(int k=0;k<=size-1;k++)
            begin
                for(int l=0;l<=size-1;l++)
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

    for(int i=0;i<=ssq-1;i++)
    begin
        for(int j=0;j<=ssq-1;j++)
        begin
            boxno=(i/size)*size+(j/size);
            flag=1;
            if(s[i][j])
            begin
                flag=0;
            end
            for(int k=0;k<=ssq-1;k++)
            begin
                prob[k][i][j]=(rp[i][k])&&(cp[j][k])&&(bp[boxno][k])&&flag;
            end
        end
    end

    sud(prob, s, 0, 0);
    $write();
    $finish();
end
endprogram

function automatic void sud(sud_options_t fnp,sud_puzzle_t fns, byte c, byte d) ;
    byte i,j,k,i0,j0,rowstart,colstart,boxno;
//    byte fnp[ssq][ssq][ssq],temp[ssq][ssq];
//    byte fns[ssq][ssq];
    sud_puzzle_t temp;
/*
    //copy into a new matrix
    for(int i=0;i<=ssq-1;i++)
    begin
        for(int j=0;j<=ssq-1;j++)
        begin
            fns[i][j]=*(b+i*ssq+j);
            for(int k=0;k<=ssq-1;k++)
            begin
                fnp[i][j][k]=*(a+i*ssq*ssq+j*ssq+k);
            end
        end
    end
*/
    if((c==ssq)&&(d==ssq))
    begin
        $write("\n The solution is\n");
        for(int i=0;i<=ssq-1;i++)
        begin
            for(int j=0;j<=ssq-1;j++)
            begin
                $write("%d ",fns[i][j]);
            end
            $write("\n");
        end
        $write("\n");

        return;
    end

    //find the vacant square
    for(int i=c;i<=ssq-1;i++)
    begin
        if(i!=c)
        begin
            d=0;
        end
        for(int j=d;j<=ssq-1;j++)
        begin
            if(fns[i][j]==0)
            begin
                i=ssq; j=ssq ; //goto out;
            end
        end
    end
    //out:
    i0=i;
    j0=j;
    if((i0==ssq)&&(j0==ssq))
    begin
        $write("\n The solution is\n");
        for(int i=0;i<=ssq-1;i++)
        begin
            for(int j=0;j<=ssq-1;j++)
            begin
                $write("%d ",fns[i][j]);
            end
            $write("\n");
        end
        $write("\n");
        return;
    end

    //find the probable number to fill up the vacant square
    for(int k=0;k<=ssq-1;k++)
    begin
        if(fnp[k][i0][j0]==1)
        begin
            for(int i=0;i<=ssq-1;i++)
            begin
                for(int j=0;j<=ssq-1;j++)
                begin
                    temp[i][j]=fnp[k][i][j];
                end
            end
            fns[i0][j0]=k+1;
            boxno=(i0/size)*size+(j0/size);
            rowstart=(boxno/size)*size;
            colstart=(boxno%size)*size;
            for(int i=0;i<=size-1;i++)
            begin
                for(int j=0;j<=size-1;j++)
                begin
                    fnp[k][rowstart+i][colstart+j]=0;
                end
            end
            for(int i=0;i<=ssq-1;i++)
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
//            sud(&fnp[0][0][0],&fns[0][0],c,d);
            sud(fnp,fns,c,d);
            for(int i=0;i<=ssq-1;i++)
            begin
                for(int j=0;j<=ssq-1;j++)
                begin
                    fnp[k][i][j]=temp[i][j];
                end
            end
        end
    end
endfunction


#include "sudoku.h"

void sud_init ( char *, char *) ;
void sud_dfs  (char *, char *,char, char);

void sud ( char *b ) 
{
    char prob[ssq][ssq][ssq];
    char s[ssq][ssq];
    char i,j;

    //copy into a new matrix
    for(i=0;i<=ssq-1;i++)
    {
        for(j=0;j<=ssq-1;j++)
        {
            s[i][j]=*(b+i*ssq+j);
        }
    }

    sud_init ( &prob[0][0][0], &s[0][0]);
    sud_dfs (&prob[0][0][0], &s[0][0], 0, 0);
}

void sud_init ( char *a, char *b) 
{
    char rp[ssq][ssq],cp[ssq][ssq],bp[ssq][ssq];
    char i,j,k,l,flag,rowstart,colstart,boxno;
    char s[ssq][ssq];

    //copy into a new matrix
    for(i=0;i<=ssq-1;i++)
    {
        for(j=0;j<=ssq-1;j++)
        {
            s[i][j]=*(b+i*ssq+j);
        }
    }

    for(i=0;i<=ssq-1;i++)
    {
        for(j=1;j<=ssq;j++)
        {
            //row probables
            rp[i][j-1]=1;
            for(k=0;k<=ssq-1;k++)
            {
                if(s[i][k]==j)
                {
                    rp[i][j-1]=0;
                    break;
                }
            }

            //column probables
            cp[i][j-1]=1;
            for(k=0;k<=ssq-1;k++)
            {
                if(s[k][i]==j)
                {
                    cp[i][j-1]=0;
                    break;
                }
            }
        }

        //box probables
        rowstart=(i/size)*size;
        colstart=(i%size)*size;
        for(j=1;j<=ssq;j++)
        {
            bp[i][j-1]=1;
            for(k=0;k<=size-1;k++)
            {
                for(l=0;l<=size-1;l++)
                {
                    if(s[rowstart+k][colstart+l]==j)
                    {
                        bp[i][j-1]=0;
                        goto out2loops;
                    }
                }
            }
            out2loops: ;
        }
    }

    for(i=0;i<=ssq-1;i++)
    {
        for(j=0;j<=ssq-1;j++)
        {
            boxno=(i/size)*size+(j/size);
            flag=1;
            if(s[i][j])
            {
                flag=0;
            }
            for(k=0;k<=ssq-1;k++)
            {
                //prob[k][i][j]=(rp[i][k])&&(cp[j][k])&&(bp[boxno][k])&&flag;
                *(a+i*ssq*ssq+j*ssq+k)=(rp[i][k])&&(cp[j][k])&&(bp[boxno][k])&&flag;
            }
        }
    }
}

void sud_dfs(char *a,char *b, char c, char d)
{
    char i,j,k,i0,j0,rowstart,colstart,boxno;
    char fnp[ssq][ssq][ssq],temp[ssq][ssq];
    char fns[ssq][ssq];

    //copy into a new matrix
    for(i=0;i<=ssq-1;i++)
    {
        for(j=0;j<=ssq-1;j++)
        {
            fns[i][j]=*(b+i*ssq+j);
            for(k=0;k<=ssq-1;k++)
            {
                fnp[i][j][k]=*(a+i*ssq*ssq+j*ssq+k);
            }
        }
    }

    if((c==ssq)&&(d==ssq))
    {
        printf("\n The solution is\n");
        for(i=0;i<=ssq-1;i++)
        {
            for(j=0;j<=ssq-1;j++)
            {
                printf("%d ",fns[i][j]);
            }
            printf("\n");
        }
        printf("\n");

        return;
    }

    //find the vacant square
    for(i=c;i<=ssq-1;i++)
    {
        if(i!=c)
        {
            d=0;
        }
        for(j=d;j<=ssq-1;j++)
        {
            if(fns[i][j]==0)
            {
                goto out;
            }
        }
    }
    out:
    i0=i;
    j0=j;
    if((i0==ssq)&&(j0==ssq))
    {
        printf("\n The solution is\n");
        for(i=0;i<=ssq-1;i++)
        {
            for(j=0;j<=ssq-1;j++)
            {
                printf("%d ",fns[i][j]);
            }
            printf("\n");
        }
        printf("\n");
        return;
    }

    //find the probable number to fill up the vacant square
    for(k=0;k<=ssq-1;k++)
    {
        if(fnp[k][i0][j0]==1)
        {
            for(i=0;i<=ssq-1;i++)
            {
                for(j=0;j<=ssq-1;j++)
                {
                    temp[i][j]=fnp[k][i][j];
                }
            }
            fns[i0][j0]=k+1;
            boxno=(i0/size)*size+(j0/size);
            rowstart=(boxno/size)*size;
            colstart=(boxno%size)*size;
            for(i=0;i<=size-1;i++)
            {
                for(j=0;j<=size-1;j++)
                {
                    fnp[k][rowstart+i][colstart+j]=0;
                }
            }
            for(i=0;i<=ssq-1;i++)
            {
                fnp[k][i][j0]=0;
                fnp[k][i0][i]=0;
            }

            c=i0;
            d=j0+1;
            if(j0==ssq-1)
            {
                if(i0==ssq-1)
                {
                    c=ssq;
                    d=ssq;
                }
                else
                {
                    c=i0+1;
                    d=0;
                }
            }
            sud_dfs(&fnp[0][0][0],&fns[0][0],c,d);
            for(i=0;i<=ssq-1;i++)
            {
                for(j=0;j<=ssq-1;j++)
                {
                    fnp[k][i][j]=temp[i][j];
                }
            }
        }
    }
}
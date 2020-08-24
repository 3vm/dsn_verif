#include "sudoku.h"

int main( void )
{
    int i,j;
    int in_num;
    char *a;
    char s[ssq][ssq]={     
                {0,1,0,8,9,0,4,0,0},
                {6,0,0,0,5,4,0,0,3},
                {4,2,0,0,0,6,7,0,0},
                {7,0,0,4,0,0,0,3,8},
                {0,9,2,0,0,0,5,4,0},
                {3,6,0,0,0,1,0,0,9},
                {0,0,8,1,0,0,0,2,6},
                {1,0,0,9,3,0,0,0,7},
                {0,0,5,0,7,8,0,1,0}    
            };

    printf("\nenter the numbers in the 9 by 9 sudoku matrix as shown in the following example\n");
    for(i=0;i<=ssq-1;i++)
    {
        for(j=0;j<=ssq-1;j++)
        {
            printf("%d ",s[i][j]);
        }
        printf("\n");
    }
    printf("\n");
/*
    for(i=0;i<=ssq-1;i++)
    {
        for(j=0;j<=ssq-1;j++)
        {
            scanf("%d",&in_num);
            s[i][j] = (char ) in_num ;
        }
    }
    //clrscr();
    printf("\nThis is the one you entered\n");
    for(i=0;i<=ssq-1;i++)
    {
        for(j=0;j<=ssq-1;j++)
        {
            printf("%d ",s[i][j]);
        }
        printf("\n");
    }
*/
    printf("\n\n");
    sud ( &s[0][0]);
    return 0;
}

#include <string.h>
#include <mpi.h>
#include <stdlib.h>
#include <stdio.h>
#include "search.h"
#include "helper.h"
#include <math.h>

void search_text (char* text, int num_lines, int line_length, char* search_string, int *occurences)
{
  /*
    Counts occurences of substring "search_string" in "text". "text" contains multiple lines and each line
    has been placed at text + line_length * num_lines since line length in the original text file can vary.
    "line_length" includes space for '\0'.

    Writes result at location pointed to by "occurences".


    *************************** PARALLEL VERSION **************************

    NOTE: For the parallel version, distribute the lines to each processor. You should only write
    to "occurences" from the root process and only access the text pointer from the root (all other processes
    call this function with text = NULL) 
  */

  // Write your parallel solution here
  int size, rank, length_per_proc, sub_string_size, count= 0, global_count;
  //MPI_Datatype string;
  MPI_Comm_size(MPI_COMM_WORLD, &size);
  MPI_Comm_rank(MPI_COMM_WORLD, &rank);
  length_per_proc = ceil(num_lines/size);    //note its ceil, no need to consider remainder or residual
  sub_string_size = length_per_proc*line_length;

  char *sub_string = malloc(sizeof(char)*(sub_string_size));

  MPI_Scatter(text, sub_string_size, MPI_CHAR , sub_string, sub_string_size, MPI_CHAR , 0, MPI_COMM_WORLD);
  
  for (int i = 0 ; i < length_per_proc ; i++)
  {
    count += count_occurences(sub_string + i * line_length, search_string);
  }
 

  MPI_Reduce(&count , &global_count , 1, MPI_INT , MPI_SUM , 0, MPI_COMM_WORLD);
  *occurences = global_count;


}

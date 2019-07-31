#include "familytree.h"
#include<omp.h>

void traverse_tree(tree *node,int numThreads){
    int father_iq, mother_iq;
    if(node==NULL){
		return 0;
	}
	else
    {
        #pragma omp task
		{
			father_iq = traverse_tree(node->father,numThreads);
		}

		#pragma omp task
		{
			mother_iq = traverse_tree(node->mother,numThreads);
		}

        node->IQ = compute_IQ(node->data,father_iq,mother_iq);
        genius[node->id] = node->IQ;
    }
}

int traverse(tree *node, int numThreads){
	// TODO implement your solution in here.
    #pragma omp parallel num_threads(numThreads)
	{
		#pragma omp single
		{
		traverse_tree(node,numThreads);
		}
    }

    return node->IQ;
}

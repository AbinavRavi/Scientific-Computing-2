import numpy as np
import matplotlib.pyplot as plt

def SD(A,b,x0):
    """
    Parameters:
    A - Input Matrix
    b - vector
    x0 - Initial solution
    """
    x = x0
    count = 0
    r = np.ones_like(b)
    while(np.linalg.norm(r)>1e-6):
        r = b - A*x
        alpha = np.transpose(r)*r/(np.transpose(r)*A*r)
        print(alpha)
        x_next = x + alpha*r
        x = x_next
        count +=1
    return x,count

def CG(A,b,x0):
    """
    Parameters:
    A - Input matrix
    b - Vector
    x0 - Initial Solution
    """
    assert np.all(A == np.transpose(A)) ,print('error conjugate gradient method cannot be used since Matrix is not Positive Semi Definite')
    x = x0
    count = 0
    r = np.ones_like(b)
    d = np.ones_like(b)
    while(np.linalg.norm(r)>1e-6):
        r = b - A*x
        alpha = np.transpose(r)*r/(np.transpose(d)*A*d)
        x = x + alpha*d
        r_next = r - alpha*A*d
        beta = np.transpose(r_next)*r_next/(np.transpose(r)*r)
        d = r_next + beta*d
        r = r_next
        count+=1
    return x,count

A = np.array([[3,2],[2,6]])
b = np.array([2,-8])
x0 = np.array([-3,-3])

value = SD(A,b,x0)
cg = CG(A,b,x0)
print(value)
print(cg)

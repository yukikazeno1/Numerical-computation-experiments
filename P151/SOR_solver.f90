program SOR_solver
    implicit none
    integer :: n, i, n_step
    real*8 :: omega, epsilon
    real*8, allocatable :: A(:,:), b(:), x(:)
    
    ! 输入矩阵维数
    print *, '请输入矩阵的维数:'
    read *, n
    
    ! 分配矩阵和向量
    allocate(A(n,n), b(n), x(n))
    
    ! 输入矩阵A
    print *, '请输入矩阵A的元素:'
    do i = 1, n
        read *, A(i, :)
    end do
    
    ! 输入向量b
    print *, '请输入向量b的元素:'
    read *, b
    
    ! 输入初始向量x
    print *, '请输入初始向量x的元素:'
    read *, x
    
    ! 输入松弛因子omega
    print *, '请输入松弛因子omega:'
    read *, omega
    
    ! 输入精度epsilon
    print *, '请输入精度epsilon:'
    read *, epsilon
    
    ! 输入最大迭代次数
    print *, '请输入最大迭代次数:'
    read *, n_step
    
    ! 调用SOR子程序
    call SOR(A, b, n, x, omega, epsilon, n_step)
    
    ! 输出结果
    print *, '解向量x为:'
    print *, x
    
    ! 释放分配的内存
    deallocate(A, b, x)
    
end program SOR_solver

subroutine SOR(A, b, n, x, omega, epsilon, n_step)
    implicit none
    integer, intent(in) :: n, n_step
    real*8, intent(in) :: omega, epsilon
    real*8, intent(inout) :: A(n,n), b(n), x(n)
    integer :: i, j, k
    real*8 :: sum, diff, max_diff
    
    do k = 1, n_step
        max_diff = 0.0
        do i = 1, n
            sum = 0.0
            do j = 1, n
                if (j /= i) then
                    sum = sum + A(i,j) * x(j)
                end if
            end do
            diff = (b(i) - sum) / A(i,i)
            x(i) = (1.0 - omega) * x(i) + omega * diff
            if (abs(diff) > max_diff) max_diff = abs(diff)
        end do
        if (max_diff < epsilon) exit
    end do
    
end subroutine SOR
       program test1
         real tic,toc
         integer p
         integer*8 :: i=1
         call CPU_TIME(tic)
         do p=1,150
            i=i*p;
         enddo
         call CPU_TIME(toc)
         print *,'time = ',toc-tic
       end

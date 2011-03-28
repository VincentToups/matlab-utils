% MYFCM Data set clustering using fuzzy c-means clustering.

%     [CENTER, U, OBJ_FCN] = MYFCM(DATA, N_CLUSTER) finds N_CLUSTER number of
%     clusters in the data set DATA. DATA is size M-by-N, where M is the number of
%     data points and N is the number of coordinates for each data point. The
%     coordinates for each cluster center are returned in the rows of the matrix
%     CENTER. The membership function matrix U contains the grade of membership of
%     each DATA point in each cluster. The values 0 and 1 indicate no membership
%     and full membership respectively. Grades between 0 and 1 indicate that the
%     data point has partial membership in a cluster. At each iteration, an
%     objective function is minimized to find the best location for the clusters
%     and its values are returned in OBJ_FCN.

%     [CENTER, ...] = MYFCM(DATA,N_CLUSTER,OPTIONS) specifies a vector of options
%     for the clustering process:
%         OPTIONS(1): exponent for the matrix U             (default: 2.0)
%         OPTIONS(2): maximum number of iterations          (default: 100)
%         OPTIONS(3): minimum amount of improvement         (default: 1e-5)
%         OPTIONS(4): info display during iteration         (default: 1)
%     The clustering process stops when the maximum number of iterations
%     is reached, or when the objective function improvement between two
%     consecutive iterations is less than the minimum amount of improvement
%     specified. Use NaN to select the default value.

%     Example
%         data = rand(100,2);
%         [center,U,obj_fcn] = myfcm(data,2);
%         plot(data(:,1), data(:,2),'o');
%         hold on;
%         maxU = max(U);
%         % Find the data points with highest grade of membership in cluster 1
%         index1 = find(U(1,:) == maxU);
%         % Find the data points with highest grade of membership in cluster 2
%         index2 = find(U(2,:) == maxU);
%         line(data(index1,1),data(index1,2),'marker','*','color','g');
%         line(data(index2,1),data(index2,2),'marker','*','color','r');
%         % Plot the cluster centers
%         plot([center([1 2],1)],[center([1 2],2)],'*','color','k')
%         hold off;


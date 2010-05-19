
seed1 = [19 31 39];
std1  = [1.5 1.5 1.5];
nt1 = 35;

seed2 = [19 35];
std2  = [1.5 1.5];
nt2 = 65;

th1 = length(seed1);
th2 = length(seed2);

lm = max( [th1 th2] );

r = randn( [nt1 th1] );
s = repmat( std1, [nt1 1] );

spikes1 = repmat(seed1, [nt1 1]) + ( s.*r );

r = randn( [nt2 th2] );
s = repmat( std2, [nt2 1] );

spikes2 = repmat(seed2, [nt2 1]) + ( s.*r );

if th1 < lm
    spikes1(1,lm) = 0;
elseif th2 < lm
    spikes2(1,lm) = 0;
end

spikes = [spikes1; spikes2];

for i=1:size(spikes,1)
    s = spikes(i,:);
    s = [s(s>0) repmat(0, [1 length(s(s==0))]) ];
    spikes(i,:) = s;
end

cl = repmat([repmat(1,[65 1]); repmat(2,[35 1])],[1 size(spikes,2)]);

prev = spikes - [2*spikes(:,1) spikes(:,1:end-1)];
prev(:,1) = abs(prev(:,1));
prev(prev<0) = 0;

post = spikes - [spikes(:,2:end) 2*spikes(:,end)];
post(post>0) = 0;
post = abs(post);

ii = find(spikes>0);
vect = [spikes(ii)'; cl(ii)'; prev(ii)'; post(ii)']';
stds = repmat(std(vect,[],2), [1 size(vect,2)]);
vect = vect./stds;

vect(:,2) = .5*vect(:,2);
vect(:,1) = 1*vect(:,1);
vect(:,3) = 2*vect(:,3);
vect(:,4) = 4*vect(:,4);

[c u p] = myfcm(vect, 6);
m = [];
i = 1;
j = 1;
for qq = 1:10
    while i < size(u,1)
        j = 1;
        while j < size(u,1)
            if i ~= j
                ut = u([i,j],:);
                ut = ut./repmat(sum(ut),[2 1]);
                ut = abs(ut-.5);
                ut = mean(ut(:));

                m(i,j) = ut
                if ut < .3
                    disp('tue')
                    r = u(j,:);
                    u(j,:) = [];
                    u(i,:) = u(i,:) + r;
                else
                    j = j + 1;
                end
            else
                j = j + 1;
                m(i,j) = 0;
            end
        end
        i = i + 1;
    end
end

u        
    
[v,ii] = max(u);

standards

trials=repmat([1:size(spikes,1)]', [1 size(spikes,2)]);
trials=trials(spikes>0);
s = spikes(spikes>0);

for i=1:length(ii)
    plot(s(i), trials(i), '.', 'Color', clr(ii(i),:));
    hold on;
end
hold off;



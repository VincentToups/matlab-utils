close all

for dcase= [1]

    switch dcase

        case 1
            filename = ['small_data/ap090203r2b_seg_4.mat']; load(filename);
        case 2
            filename = 'small_data/ap0502401r3b_seg_1.mat'; load(filename);
        case 3
            filename = 'small_data/ap052701r1d_seg_2.mat'; load(filename);
        case 4
            filename = 'small_data/ap052701r1d_seg_3.mat'; load(filename);
        case 5
            filename = 'small_data/ap052701r1d_seg_4.mat'; load(filename);
        case 6
            filename = 'small_data/ap052701r1d_seg_5.mat'; load(filename);
        case 7
            filename = 'small_data/ap052801r1b_seg_3.mat'; load(filename);
        case 8
            filename = 'small_data/ap052801r1b_seg_4.mat'; load(filename);
        case 9
            filename = 'small_data/ap082003r1b_seg_3.mat'; load(filename);
        case 10
            filename = 'small_data/ap082003r1b_seg_5.mat'; load(filename);
        case 11
            filename = 'small_data/ap082503r1b_seg_2.mat'; load(filename);
        case 12
            filename = 'small_data/ap082503r1b_seg_3.mat'; load(filename);
        case 13
            filename = 'small_data/ap082603r1b_seg_4.mat'; load(filename);
        case 14
            filename = 'small_data/ap090203r2b_seg_2.mat'; load(filename);
        case 15
            filename = 'small_data/ap090203r2b_seg_3.mat'; load(filename);
        case 16
            filename = 'small_data/ap090203r2b_seg_4.mat'; load(filename);
        case 17
            filename = 'small_data/ap090203r2c_seg_2.mat'; load(filename);
        case 18
            filename = 'small_data/ap091503r3b_seg_3.mat'; load(filename);
        case 19
            filename = 'small_data/ap091503r3b_seg_4.mat'; load(filename);

        case 20
            data.events = [repmat([0 1 0],[50 1]); repmat([1 0 1],[50 1])];

        case 21
            data.events = [repmat([0 1 0],[50 1]); repmat([1 0 1],[50 1])];
            p = patsigfindp(data.events);
            data.events = patsigsurr(p,size(data.events,1));
            data.name = 'bad_data';
            filename = 'bad_data';
    end

    close all
    
    x = (data.events>0)+0;

    r = sum(x)/size(x,1);
    [s,sv,sr,ss] = pattern_sig(x,r,1000);
    %[sc,svc,src,ssc] = pattern_sigc(x,r,1000);
    [vc,vvc,vrc,vsc] = vpatsig(x,r,1000);

    subplot(3,1,1);
    hist(ss,300);
    b = hist(ss,300);
    hold on;
    plot(sr,max(b),'o');

%    subplot(3,1,2);
%    hist(ssc,300);
%    b = hist(ssc,300);
%    hold on;
%    plot(src,max(b),'o');
%
    subplot(3,1,2);
    hist(vsc,300);
    b = hist(vsc,300);
    hold on;
    plot(vrc,max(b),'o');
    
    name = filename(filename~='_');
    name = strrep(name,'.mat','');
    name = name(name~='/');

    title(name);
    vprint(['pat_sig_fig_' name]);

end

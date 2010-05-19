#include<stdio.h>
#include<stdlib.h>
#include"merstwist.h"

int betweenp(double x, double l, double b){
  return (x >= l && x <= b);
}

int read_until_enclosing(FILE * fin, double t, double * start_ref, double * end_ref, double * rate_ref){
  int done;
  int nread;
  done =0;
  while(!done) {
	nread = fscanf(fin,"%lf %lf %lf", start_ref, end_ref, rate_ref);
	/*printf("nread %d\n",nread);*/
	if(nread!=3){
	  done = 1;
	  *start_ref = t;
	  *end_ref = 1e16;
	}else{
	  if(betweenp(t,*start_ref,*end_ref)){
		done = 1;
	  }
	  else{
		done = 0;
	  }
	}	
  }
}

void rate_spike_generator(FILE *fin, FILE *fout){
  double t0,tf,dt,n;
  double t, test;
  int seed;
  int * counts;
  int i;
  int counter;
  int total;
  int total_spikes;
  
  
  double current_start, current_end, current_rate;
  int done;
  int ni;

  done = fscanf(fin,"%lf%lf%lf%lf%d", &t0, &tf, &dt, &n, &seed);
  /*printf("done is %d\n",done); */
  done = (done==5);
  printf("read parameters: %f %f %f %f %d\n", t0, tf, dt, n, seed);
  init_genrand(seed);

  t = 0;
  read_until_enclosing(fin,t,&current_start,&current_end,&current_rate);
  /*printf("cs %f ce %f cr %f\n", current_start, current_end, current_rate);*/
  done = 0;
  
  counts = malloc(sizeof(int)*n);
  for(i=0;i<n;i++){
	counts[i] = 1;
  }
  
  counter = 0;
  total = tf/dt;

  while(!done){
	if(t>current_end){
	  read_until_enclosing(fin,t,&current_start,&current_end, &current_rate);
	}
	for(ni=0;ni<n;ni++){
	  test = genrand_real1();
	  /*printf("test is %f\n", test);*/
	  if(test<current_rate*dt){
		fprintf(fout,"%d %d %f\n",ni+1,counts[ni],t+(genrand_real1())*dt/2.0);
		counts[ni] = counts[ni] + 1;
	  }
	}
	t = t + dt;
	if(t>tf){
	  done = 1;
	}
	if((counter % 1000)==0){
	  printf("generating spikes - %d (%d/%d) pct. done (t = %f, dt = %f, tf = %f) \n", ((int) (100.0*((float) counter)/((float) total))), counter, total, t, dt, tf );
	}
	counter = counter + 1;
  }
  total_spikes =0;
  for(i=0;i<n;i=i+1){
	total_spikes  = total_spikes + counts[i];
  }
  printf("generated %f spikes per synapse (%d synapses)\n", ((float) total_spikes)/n, (int) n);
  free(counts);
}

int main(int argc, char ** argv){
  /*printf("Found %d input arguments.\n",argc);*/
  FILE * fin;
  FILE * fout;
  if (argc==3) {
	fin = fopen(argv[1],"r");
	fout = fopen(argv[2],"w");
  } else if (argc==2) {
	fin = fopen(argv[1],"r");
	fout = stdout;
  } else if (argc==1) {
	fin = stdin;
	fout = stdout;
  }  
  rate_spike_generator(fin, fout);
  fclose(fin);
  fclose(fout);
  printf("done generating spikes\n");
  return 0;
}

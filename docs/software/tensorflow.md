# TensorFlow at TACC
*Last update: November 16, 2021*

Scientists across domains are actively exploring and adopting deep learning as a cutting-edge methodology to make research breakthrough. At TACC, our mission is to enable discoveries that advance science and society through the application of advanced computing technologies. Thus, we are embracing this new type of application on our high end computing platforms.

TACC supports the TensorFlow+Horovod stack. This framework exposes high level interfaces for deep learning architecture specification, model training, tuning, and validation. Deep learning practitioners and domain scientists who are exploring the deep learning methodology should consider this framework for their research.

This document details how to install TensorFlow, then download and run benchmarks in both single- and multi-node modes. Due to variations in TensorFlow and Python versions, and their compatabilities with the Intel compilers and CUDA libraries, the installation instructions are quite specific. Pay careful attention to the installation instructions.

## [Installations at TACC](#installations) { #installations }

TensorFlow is installed on TACC's [Lonestar6][LONESTAR6UG], [Frontera][FRONTERAUG], [Stampede2][STAMPEDE2UG], and [Maverick2][MAVERICK2UG] resources.

* Parallel Training with TensorFlow and Horovod is available on both Stampede2 and Maverick2.
* TensorFlow v2.1 is available on Stampede2.

!!! caution
	Running programs or performing computations on the login nodes may result in account suspension.<br>
	All of the following examples are run on compute, not login, nodes.<br>
	Use TACC's <a href="../idev"><code>idev</code></a> utility to grab compute node/s when conducting any TensorFlow activities.


## [TensorFlow on Lonestar6](#lonestar6) { #lonestar6 }

These instructions detail installing and running TensorFlow benchmarks on Lonestar6. Lonestar6 runs TensorFlow 2.6.1 with CUDA/11.4, Python 3.9.7 and Intel 19.

To install Horovod: 

<pre class="cmd-line">login1$ <b>module load cuda/11.4 cudnn/8.2.4 nccl/2.11.4</b>
login1$ <b>pip3 install --user gast==0.4.0 keras==2.6.0 tensorflow-gpu==2.6.1 --no-cache-dir</b>
login1$ <b>HOROVOD_CUDA_HOME=$TACC_CUDA_DIR HOROVOD_NCCL_HOME=$TACC_NCCL_DIR \
			CC=icc HOROVOD_GPU_ALLREDUCE=NCCL HOROVOD_GPU_BROADCAST=NCCL HOROVOD_WITH_TENSORFLOW=1 \
			pip3 install horovod --no-cache-dir</b></pre>


### [Single-Node](#lonestar6-singlenode) { #lonestar6-singlenode }

To run a single-node job benchmark on one GPU, first create an `idev` session in LS6's [`gpu_a100`](../../hpcugs/6lonestar/lonestar6#queues) queue: 

<pre class="cmd-line">login1$ <b>idev -N 1 -n 2 -p gpu_a100</b></pre>

Once the `idev` session is created, run the benchmark on a single node, using one GPU:

<pre class="cmd-line">c307-001.ls6$ <b>cds; git clone https://github.com/tensorflow/benchmarks.git</b>
c307-001.ls6$ <b>cd benchmarks</b>
c307-001.ls6$ <b>module load cuda/11.4 cudnn/8.2.4 nccl/2.11.4</b>
c307-001.ls6$ <b>python3 scripts/tf_cnn_benchmarks/tf_cnn_benchmarks.py \
				--num_gpus=1 --model resnet50 --batch_size 32 --num_batches 200</b></pre>

Run the same benchmark using both GPUs:

<pre class="cmd-line">c307-001.ls6$ <b>python3 scripts/tf_cnn_benchmarks/tf_cnn_benchmarks.py \
				--num_gpus=2 --model resnet50 --batch_size 32 --num_batches 200</b></pre>



### [Multi-Node](#lonestar6-multinode) { #lonestar6-multinode }

To run a multi-node job benchmark, first create a multi-node `idev` session in LS6's [`gpu_a100`](../../hpcugs/6lonestar/lonestar6#queues) queue: 

<pre class="cmd-line">login1$ <b>idev -N 2 -n 4 -p gpu_a100</b></pre>

Once the `idev` session is created, run the benchmarks on two nodes, using four GPUs:

<pre class="cmd-line">c305-000$ <b>cds;git clone  https://github.com/tensorflow/benchmarks.git</b>
c305-000$ <b>cd benchmarks</b>
c305-000$ <b>module load cuda/11.4 cudnn/8.2.4 nccl/2.11.4</b>
c305-000$ <b>ibrun -np 4 python3 scripts/tf_cnn_benchmarks/tf_cnn_benchmarks.py \
			--num_gpus=1 --variable_update=horovod --model resnet50 --batch_size 32 --num_batches 200</b></pre>


## [TensorFlow on Maverick2](#maverick2) { #maverick2 }

These instructions detail installing and running TensorFlow benchmarks on Maverick2. Maverick2 runs TensorFlow 2.1.0 with Python 3.7.0 and Intel 18.

Maverick2 supports CUDA/10.0, and CUDA/10.1. Use the respective CUDA version for your TensorFlow installation with Python 3.7.

<pre class="cmd-line">
c123-456$ <b>module load intel/18.0.2 python3/3.7.0</b>
c123-456$ <b>module load cuda/10.1 cudnn/7.6.5 nccl/2.5.6</b>
c123-456$ <b>pip3 install --user grpcio==1.28.1 tensorflow-gpu==2.1.0 --no-cache-dir</b></pre>

We suggest installing Horovod version 0.19.2. If you wish to install other versions of Horovod, please [submit a support ticket][CREATETICKET] with the subject "Request for Horovod" and TACC staff will provide special instructions.

<pre class="cmd-line">
c123-456$ <b>HOROVOD_CUDA_HOME=$TACC_CUDA_DIR HOROVOD_NCCL_HOME=$TACC_NCCL_DIR CC=gcc \
	HOROVOD_GPU_ALLREDUCE=NCCL HOROVOD_GPU_BROADCAST=NCCL HOROVOD_WITH_TENSORFLOW=1 pip3 install \
	--user horovod==0.19.2 --no-cache-dir</b></pre>

### [Single-Node](#maverick2-singlenode) { #maverick2-singlenode }

Download the tensorflow benchmark to your `$WORK` directory, then check out the branch that matches your tensorflow version.

<pre class="cmd-line">
c123-456$ <b>cdw; git clone https://github.com/tensorflow/benchmarks.git</b>
c123-456$ <b>cd benchmarks</b>
c123-456$ <b>git checkout cnn_tf_v2.1_compatible</b></pre>

Benchmark the performance with the synthetic dataset on 1 GPU:

<pre class="cmd-line">
c123-456$ <b>cd scripts/tf_cnn_benchmarks</b>
c123-456$ <b>module load intel/18.0.2 python3/3.7.0 cuda/10.1 cudnn/7.6.5 nccl/2.5.6</b>
c123-456$ <b>python3 tf_cnn_benchmarks.py --num_gpus=1 --model resnet50 --batch_size 32 --num_batches 200</b></pre>

Benchmark the performance with the synthetic dataset on 4 GPUs:

<pre class="cmd-line">
c123-456$ <b>cd scripts/tf_cnn_benchmarks</b>
c123-456$ <b>module load intel/18.0.2 python3/3.7.0 cuda/10.1 cudnn/7.6.5 nccl/2.5.6</b>
c123-456$ <b>ibrun -np 4 python3 tf_cnn_benchmarks.py --variable_update=horovod \
            --num_gpus=1 --model resnet50 --batch_size 32 --num_batches 200 --allow_growth=True</b></pre>

### [Multi-Node](#maverick2-multinode) { #maverick2-multinode }

Download the TensorFlow benchmark to your `$WORK` directory. Check out the branch that matches your tensorflow version. This example runs on two nodes in Maverick2's `gtx` queue (8 GPUs).

<pre class="cmd-line">
c123-456$ <b>cdw; git clone https://github.com/tensorflow/benchmarks.git</b>
c123-456$ <b>git checkout cnn_tf_v2.1_compatible</b></pre>

Benchmark the performance with synthetic dataset on these two 2 nodes using 8 GPUs:

<pre class="cmd-line">
c123-456$ <b>cd scripts/tf_cnn_benchmarks</b>
c123-456$ <b>module load intel/18.0.2 python3/3.7.0 cuda/10.1 cudnn/7.6.5 nccl/2.5.6</b>
c123-456$ <b>ibrun -np 8 python3 tf_cnn_benchmarks.py --variable_update=horovod \
            --num_gpus=1 --model resnet50 --batch_size 32 --num_batches 200 --allow_growth=True</b></pre>

## [TensorFlow on Frontera](#frontera) { #frontera }

These instructions detail installing and running TensorFlow benchmarks on Frontera RTX. Frontera RTX runs TensorFlow 2.1.0 with Python 3.7.0 and Intel 19. Frontera supports CUDA10.0 and CUDA/10.1. Use the appropriate CUDA version for your TensorFlow installation with Python 3.7.6.

<pre class="cmd-line">
c123-456$ <b>module load python3 </b>
c123-456$ <b>module load cuda/10.1 cudnn/7.6.5 nccl/2.5.6</b>
c123-456$ <b>pip3 install --user grpcio==1.28.1 tensorflow-gpu==2.1.0 --no-cache-dir</b></pre>

We suggest installing Horovod version 0.19.2. If you wish to install other versions of Horovod, please <a href="https://portal.tacc.utexas.edu/tacc-consulting/-/consult/tickets/create">submit a support ticket</a> with the subject "Request for Horovod" and TACC staff will provide special instructions.

<pre class="cmd-line">c123-456$ <b>HOROVOD_CUDA_HOME=$TACC_CUDA_DIR HOROVOD_NCCL_HOME=$TACC_NCCL_DIR CC=gcc \
	HOROVOD_GPU_ALLREDUCE=NCCL HOROVOD_GPU_BROADCAST=NCCL HOROVOD_WITH_TENSORFLOW=1 pip3 install \
	--user horovod==0.19.2 --no-cache-dir</b></pre>

### [Single-Node](#frontera-singlenode) { #frontera-singlenode }

Download the tensorflow benchmark to your `$WORK` directory, then check out the branch that matches your tensorflow version.

<pre class="cmd-line">
c123-456$ <b>cds; git clone https://github.com/tensorflow/benchmarks.git</b>
c123-456$ <b>cd benchmarks </b> 
c123-456$ <b>git checkout cnn_tf_v2.1_compatible</b></pre>

Benchmark the performance with synthetic dataset on 1 GPU

<pre class="cmd-line">
c123-456$ <b>cd scripts/tf_cnn_benchmarks</b>
c123-456$ <b>module load python3/3.7.0 cuda/10.1 cudnn/7.6.5 nccl/2.5.6</b>
c123-456$ <b>python3 tf_cnn_benchmarks.py --num_gpus=1 --model resnet50 --batch_size 32 --num_batches 200</b></pre>

Benchmark the performance with synthetic dataset on 4 GPUs

<pre class="cmd-line">
c123-456$ <b>cd scripts/tf_cnn_benchmarks</b>
c123-456$ <b>module load python3/3.7.0 cuda/10.1 cudnn/7.6.5 nccl/2.5.6</b>
c123-456$ <b>ibrun -np 4 python3 tf_cnn_benchmarks.py --variable_update=horovod --num_gpus=1 \
	--model resnet50 --batch_size 32 --num_batches 200 --allow_growth=True</b></pre>

### [Multi-Node](#frontera-multinode) { #frontera-multinode }

Download the TensorFlow benchmark to your `$WORK` directory. Check out the branch that matches your tensorflow version. This example runs on two nodes in the `rtx queue` (8 GPUs).

<pre class="cmd-line">
c123-456$ <b>cds; git clone https://github.com/tensorflow/benchmarks.git</b>
c123-456$ <b>git checkout cnn_tf_v2.1_compatible</b></pre>

Benchmark the performance with synthetic dataset on these two 2 nodes using 8 GPUs

<pre class="cmd-line">
c123-456$ <b>cd scripts/tf_cnn_benchmarks</b>
c123-456$ <b>module load python3/3.7.0 cuda/10.1 cudnn/7.6.5 nccl/2.5.6</b>
c123-456$ <b>ibrun -np 8 python3 tf_cnn_benchmarks.py --variable_update=horovod --num_gpus=1 \
	--model resnet50 --batch_size 32 --num_batches 200 --allow_growth=True</b></pre>

## [TensorFlow on Stampede2](#stampede2) { #stampede2 }

These instructions detail installing and running TensorFlow benchmarks on Stampede2. Stampede2 runs TensorFlow 2.1.0 with Python 3.7 and Intel 18.

Use TACC's `idev` utility to grab a single compute node for 1 hour in Stampede2's [skx-dev queue](../../hpcugs/stampede2/stampede2#queues):

<pre class="cmd-line">login1$ <b>idev -p skx-dev -N 1 -n 1 -m 60</b></pre>

Install TensorFlow 2.1 using the default intel/18.0.2 compiler and Python 3.7:

<pre class="cmd-line">
c123-456$ <b>module load intel/18.0.2 python3/3.7.0</b>
c123-456$ <b>pip3 install --user tensorflow==2.1.0 --no-cache-dir</b></pre>

To install horovod v0.19.2:

<pre class="cmd-line">
c123-456$ <b>CC=gcc HOROVOD_WITH_TENSORFLOW=1 pip3 install --user horovod==0.19.2 --no-cache-dir --no-cache-dir</b></pre>

### [Single-Node](#stampede2-singlenode) { #stampede2-singlenode }

If you're not already on a compute node, then use TACC's `idev` utility to grab a single compute node for 1 hour:
<pre class="cmd-line">
login1$ <b>idev -p skx-dev -N 1 -n 1 -m 60</b></pre>

Download the TensorFlow benchmark to your `$SCRATCH` directory. Check out the corresponding branch for your TensorFlow version. In this example we used `cnn_tf_v2.1_compatible`.

<pre class="cmd-line">
c123-456$ <b>cd $SCRATCH</b>
c123-456$ <b>git clone https://github.com/tensorflow/benchmarks.git</b>
c123-456$ <b>cd benchmarks</b>
c123-456$ <b>git checkout cnn_tf_v2.1_compatible</b></pre>

Benchmark the performance with a synthetic dataset:

<pre class="cmd-line">
c123-456$ <b>cd scripts/tf_cnn_benchmarks</b>
c123-456$ <b>export KMP_BLOCKTIME=0</b>
c123-456$ <b>export KMP_AFFINITY="granularity=fine,verbose,compact,1,0"</b>
c123-456$ <b>export OMP_NUM_THREADS=46</b>
c123-456$ <b>python3 tf_cnn_benchmarks.py --model resnet50 --batch_size 128 --data_format NHWC \
	--num_intra_threads 46 --num_inter_threads 2 --distortions=False --num_batches 100</b></pre>

### [Multi-Node](#stampede2-multinode) { #stampede2-multinode }

If you're not already on a compute node, then use TACC's `idev` utility to grab two compute nodes for 1 hour:

<pre class="cmd-line">
login1$ <b>idev -p skx-dev -N 2 -n 2 -m 60</b></pre>

Download the TensorFlow benchmark to your `$SCRATCH` directory. Check out the corresponding branch for your TensorFlow version. In this example, we used `cnn_tf_v2.1_compatible`.

<pre class="cmd-line">
c123-456$ <b>cd $SCRATCH</b>
c123-456$ <b>git clone https://github.com/tensorflow/benchmarks.git</b>
c123-456$ <b>git checkout cnn_tf_v2.1_compatible</b></pre>

Benchmark the performance with a synthetic dataset on 4 nodes:

<pre class="cmd-line">
c123-456$ <b>module load intel/18.0.2 python3/3.7.0 </b>
c123-456$ <b>cd benchmarks/scripts/tf_cnn_benchmarks</b>
c123-456$ <b>export KMP_BLOCKTIME=0</b>
c123-456$ <b>export KMP_AFFINITY="granularity=fine,verbose,compact,1,0"</b>
c123-456$ <b>export OMP_NUM_THREADS=46</b>
c123-456$ <b>ibrun -np 2 python3 tf_cnn_benchmarks.py --model resnet50 --batch_size 128 \
	--variable_update horovod --data_format NCHW --num_intra_threads 46 --num_inter_threads 2 \
	--num_batches 100</b></pre>

The parameters for this last command are defined as follows:

* `-model` specifies the neural network model
* `-batch_size` specifies the number of samples in each iteration
* `-variable_update` specifies using horovod to synchronize gradients
* `-data_format` informs TF the nested data format comes in the order of sample count, channel, height, and width
* `-num_intra_threads` specifies the number of threads used for computation within a single operation
* `-num_inter_threads` specifies the number of threads used for independent operations
* `-num_batches` specifies the total number of iterations to run

		
## [FAQ](#faq) { #faq }

Q: **I have missing Python packages when using TensorFlow. What shall I do?**  

A: Deep learning frameworks usually depend on many other packages. e.g., the [Caffe package dependency list](https://github.com/intel/caffe/blob/master/python/requirements.txt). On TACC resources, you can install these packages in user space by running:

<pre class="cmd-line">$ <b>pip install --user <i>package-name</i></b></pre>

## [References](#refs) { #refs }

* [Maverick2 User Guide][MAVERICK2UG]
* [Github: TensorFlow](https://github.com/tensorflow/tensorflow)
* [Stampede2 User Guide][STAMPEDE2UG]

{% include 'aliases.md' %}

/ Zhao Zhang, Greg Zynda, Susan Lindsey
/ https://portal.tacc.utexas.edu/software/tensorflow
<p><span style="font-size:225%; font-weight:bold;">TensorFlow at TACC<br></span>
<span style="font-size:90%"><i>Last update: November 16, 2021</i></span></p>

#top
	:markdown
		Scientists across domains are actively exploring and adopting deep learning as a cutting-edge methodology to make research breakthrough. At TACC, our mission is to enable discoveries that advance science and society through the application of advanced computing technologies. Thus, we are embracing this new type of application on our high end computing platforms.

		TACC supports the TensorFlow+Horovod stack. This framework exposes high level interfaces for deep learning architecture specification, model training, tuning, and validation. Deep learning practitioners and domain scientists who are exploring the deep learning methodology should consider this framework for their research.

		This document details how to install TensorFlow, then download and run benchmarks in both single- and multi-node modes. Due to variations in TensorFlow and Python versions, and their compatabilities with the Intel compilers and CUDA libraries, the installation instructions are quite specific. Pay careful attention to the installation instructions.

#installations
	:markdown
		# [Installations at TACC](#installations)

		TensorFlow is installed on TACC's [Lonestar6](https://portal.tacc.utexas.edu/user-guides/lonestar6), [Frontera](https://frontera-portal.tacc.utexas.edu/user-guide/), [Stampede2](https://portal.tacc.utexas.edu/user-guides/stampede2), [Longhorn](https://portal.tacc.utexas.edu/user-guides/longhorn) and [Maverick2](https://portal.tacc.utexas.edu/user-guides/maverick2) resources.

		* Parallel Training with TensorFlow and Horovod is available on both Stampede2 and Maverick2.
		* TensorFlow v2.1 is available on Stampede2.
		* Current Longhorn Tensorflow installations are 1.13.1, 1.14.0, 1.15.2, 2.1.0

		<p class="portlet-msg-alert">Running programs or performing computations on the login nodes may result in account suspension.<br>
		All of the following examples are run on compute, not login, nodes.<br>
		Use TACC's [`idev`](https://portal.tacc.utexas.edu/software/idev) utility to grab compute node/s when conducting any TensorFlow activities.</pre>


#lonestar6
	:markdown
		# [TensorFlow on Lonestar6](#lonestar6)

		These instructions detail installing and running TensorFlow benchmarks on Lonestar6. Lonestar6 runs TensorFlow 2.6.1 with CUDA/11.4, Python 3.9.7 and Intel 19.

		To install Horovod: 

		<pre class="cmd-line">login1$ <b>module load cuda/11.4 cudnn/8.2.4 nccl/2.11.4</b>
		login1$ <b>pip3 install --user gast==0.4.0 keras==2.6.0 tensorflow-gpu==2.6.1 --no-cache-dir</b>
		login1$ <b>HOROVOD_CUDA_HOME=$TACC_CUDA_DIR HOROVOD_NCCL_HOME=$TACC_NCCL_DIR \
					CC=icc HOROVOD_GPU_ALLREDUCE=NCCL HOROVOD_GPU_BROADCAST=NCCL HOROVOD_WITH_TENSORFLOW=1 \
					pip3 install horovod --no-cache-dir</b></pre>


#lonestar6-singlenode
	:markdown
		## [Single-Node](#lonestar6-singlenode)

		To run a single-node job benchmark on one GPU, first create an `idev` session in LS6's [`gpu_a100`](/user-guides/lonestar6#queues) queue: 

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



#lonestar6-multinode
	:markdown
		## [Multi-Node](#lonestar6-multinode)

		To run a multi-node job benchmark, first create a multi-node `idev` session in LS6's [`gpu_a100`](/user-guides/lonestar6#queues) queue: 

		<pre class="cmd-line">login1$ <b>idev -N 2 -n 4 -p gpu_a100</b></pre>

		Once the `idev` session is created, run the benchmarks on two nodes, using four GPUs:

		<pre class="cmd-line">c305-000$ <b>cds;git clone  https://github.com/tensorflow/benchmarks.git</b>
		c305-000$ <b>cd benchmarks</b>
		c305-000$ <b>module load cuda/11.4 cudnn/8.2.4 nccl/2.11.4</b>
		c305-000$ <b>ibrun -np 4 python3 scripts/tf_cnn_benchmarks/tf_cnn_benchmarks.py \
					--num_gpus=1 --variable_update=horovod --model resnet50 --batch_size 32 --num_batches 200</b></pre>


#maverick2
	:markdown
		# [TensorFlow on Maverick2](#maverick2)

		These instructions detail installing and running TensorFlow benchmarks on Maverick2. Maverick2 runs TensorFlow 2.1.0 with Python 3.7.0 and Intel 18.

		Maverick2 supports CUDA/10.0, and CUDA/10.1. Use the respective CUDA version for your TensorFlow installation with Python 3.7.

		<pre class="cmd-line">
		c123-456$ <b>module load intel/18.0.2 python3/3.7.0</b>
		c123-456$ <b>module load cuda/10.1 cudnn/7.6.5 nccl/2.5.6</b>
		c123-456$ <b>pip3 install --user grpcio==1.28.1 tensorflow-gpu==2.1.0 --no-cache-dir</b></pre>

		We suggest installing Horovod version 0.19.2. If you wish to install other versions of Horovod, please [submit a support ticket](https://portal.tacc.utexas.edu/tacc-consulting/-/consult/tickets/create) with the subject "Request for Horovod" and TACC staff will provide special instructions.

		<pre class="cmd-line">
		c123-456$ <b>HOROVOD_CUDA_HOME=$TACC_CUDA_DIR HOROVOD_NCCL_HOME=$TACC_NCCL_DIR CC=gcc \
			HOROVOD_GPU_ALLREDUCE=NCCL HOROVOD_GPU_BROADCAST=NCCL HOROVOD_WITH_TENSORFLOW=1 pip3 install \
			--user horovod==0.19.2 --no-cache-dir</b></pre>

#maverick2-singlenode
	:markdown
		## [Single-Node](#maverick2-singlenode)

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

#maverick2-multinode
	:markdown
		## [Multi-Node](#maverick2-multinode)

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

#frontera
	:markdown
		# [TensorFlow on Frontera](#frontera)

		These instructions detail installing and running TensorFlow benchmarks on Frontera RTX. Frontera RTX runs TensorFlow 2.1.0 with Python 3.7.0 and Intel 19. Frontera supports CUDA10.0 and CUDA/10.1. Use the appropriate CUDA version for your TensorFlow installation with Python 3.7.6.

		<pre class="cmd-line">
		c123-456$ <b>module load python3 </b>
		c123-456$ <b>module load cuda/10.1 cudnn/7.6.5 nccl/2.5.6</b>
		c123-456$ <b>pip3 install --user grpcio==1.28.1 tensorflow-gpu==2.1.0 --no-cache-dir</b></pre>

		We suggest installing Horovod version 0.19.2. If you wish to install other versions of Horovod, please <a href="https://portal.tacc.utexas.edu/tacc-consulting/-/consult/tickets/create">submit a support ticket</a> with the subject "Request for Horovod" and TACC staff will provide special instructions.

		<pre class="cmd-line">c123-456$ <b>HOROVOD_CUDA_HOME=$TACC_CUDA_DIR HOROVOD_NCCL_HOME=$TACC_NCCL_DIR CC=gcc \
			HOROVOD_GPU_ALLREDUCE=NCCL HOROVOD_GPU_BROADCAST=NCCL HOROVOD_WITH_TENSORFLOW=1 pip3 install \
			--user horovod==0.19.2 --no-cache-dir</b></pre>

#frontera-singlenode
	:markdown
		## [Single-Node](#frontera-singlenode)

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

#frontera-multinode
	:markdown
		## [Multi-Node](#frontera-multinode)

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

#stampede2
	:markdown
		# [TensorFlow on Stampede2](#stampede2)

		These instructions detail installing and running TensorFlow benchmarks on Stampede2. Stampede2 runs TensorFlow 2.1.0 with Python 3.7 and Intel 18.

		Use TACC's `idev` utility to grab a single compute node for 1 hour in Stampede2's [skx-dev queue](https://portal.tacc.utexas.edu/user-guides/stampede2#queues):

		<pre class="cmd-line">login1$ <b>idev -p skx-dev -N 1 -n 1 -m 60</b></pre>

		Install TensorFlow 2.1 using the default intel/18.0.2 compiler and Python 3.7:

		<pre class="cmd-line">
		c123-456$ <b>module load intel/18.0.2 python3/3.7.0</b>
		c123-456$ <b>pip3 install --user tensorflow==2.1.0 --no-cache-dir</b></pre>

		To install horovod v0.19.2:

		<pre class="cmd-line">
		c123-456$ <b>CC=gcc HOROVOD_WITH_TENSORFLOW=1 pip3 install --user horovod==0.19.2 --no-cache-dir --no-cache-dir</b></pre>

#stampede2-singlenode
	:markdown
		## [Single-Node](#stampede2-singlenode)

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

#stampede2-multinode
	:markdown
		## [Multi-Node](#stampede2-multinode)

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

#longhorn
	:markdown
		# [Tensorflow on Longhorn](#longhorn)

		Multiple versions of TensorFlow for both Python 2 and Python 3 are available through standard LMOD modules. These versions can be listed with

		<pre class="cmd-line">$ <b>module spider tensorflow</b></pre>

		Notice that Python 2 versions are in the `tensorflow-py2` module and Python 3 versions are in the `tensorflow-py3` module. Each of these modules activates the IBM PowerAI conda environment that they originate from, so your shell prompt will change when loaded.

		<pre class="cmd-line">
		longhorn$ <b>module load tensorflow-py3/2.1.0</b>
		(py3_powerai_1.7.0) longhorn$</pre>

		For more information about interacting with these conda environments, please refer to the <a href="https://portal.tacc.utexas.edu/user-guides/longhorn#conda-python-environments">Longhorn user guide</a>.

#longhorn-singlenode
	:markdown
		## [Single-Node](#longhorn-singlenode)

		Each Longhorn compute node contains four Nvidia V100 GPUs. This means one to four GPUs are available for use in a single-node job. Generic TensorFlow code can take advantage of a single GPU at a time, but multiple can be utilized either through TensorFlow's [distribute](https://www.tensorflow.org/guide/distributed_training) module or [Horovod](https://github.com/horovod/horovod), which comes pre-installed in each system environment.

		* Allocate a single compute node with 4 tasks (one per GPU)

			<pre class="cmd-line">login1$ <b>idev -N 1 -n 4 -p v100</b></pre>

		* Load TensorFlow 2.1.0

			<pre class="cmd-line">c001-006$ <b>module load tensorflow-py3/2.1.0</b></pre>

		* Download and checkout benchmarks compatible with TF 2.1

			<pre class="cmd-line">
			(py3_powerai_1.7.0) c001-006$ <b>git clone --branch cnn_tf_v2.1_compatible \
				https://github.com/tensorflow/benchmarks.git</b>
			...
			(py3_powerai_1.7.0) c001-006$ <b>cd benchmarks</b></pre>


		* Run using a single GPU

			<pre class="cmd-line">
			(py3_powerai_1.7.0) c001-006$ <b>python scripts/tf_cnn_benchmarks/tf_cnn_benchmarks.py \
				--num_gpus=1 --model resnet50 --batch_size 32 --num_batches 100</b>
			2020-06-04 16:46:56.253765: I tensorflow/stream_executor/platform/default/dso_loader.cc:44] 
			Successfully opened dynamic library libcudart.so.10.2
			...
			100        images/sec: 343.4 +/- 0.3 (jitter = 3.6)        7.794
			----------------------------------------------------------------
			total images/sec: 343.19
			----------------------------------------------------------------
			</pre>

		* Run using four GPUs using `ParameterServer` (no `ibrun`). See [Distributed Training with TensorFlow](https://www.tensorflow.org/guide/distributed_training).

			<pre class="cmd-line">
			(py3_powerai_1.7.0) c001-006$ <b>python scripts/tf_cnn_benchmarks/tf_cnn_benchmarks.py \
				--num_gpus=4 --model resnet50 --batch_size 32 --num_batches 100</b>
			2020-06-04 16:53:09.078324: I tensorflow/stream_executor/platform/default/dso_loader.cc:44] 
			Successfully opened dynamic library libcudart.so.10.2
			...
			100        images/sec: 1269.6 +/- 0.7 (jitter = 4.4)        7.682
			----------------------------------------------------------------
			total images/sec: 1268.75
			----------------------------------------------------------------
			</pre>


		* Run on four GPUs using `ibrun` and Horovod:

			<pre class="cmd-line">
			(py3_powerai_1.7.0) c001-006$ <b>ibrun -n 4 python scripts/tf_cnn_benchmarks/tf_cnn_benchmarks.py \
				--num_gpus=1 --model resnet50 --batch_size 32 --num_batches 100 --variable_update=horovod</b>
			TACC:  Starting up job 23600 
			TACC:  Setting up parallel environment for OpenMPI mpirun. 
			TACC:  Starting parallel tasks...
			...
			100        images/sec: 322.6 +/- 0.4 (jitter = 3.9)        7.716
			----------------------------------------------------------------
			total images/sec: 1289.70
			----------------------------------------------------------------
			TACC:  Shutdown complete. Exiting.</pre>

#longhorn-multinode
	:markdown
		## [Multi-Node](#longhorn-multinode)

		Once again, each Longhorn compute node contains four Nvidia V100 GPUs. We recommend using Horovod to scale your training or classification past a single node. This means a single process for each GPU.

		1. Allocate two compute nodes with 8 tasks (one per GPU)

			<pre class="cmd-line">
			login1$ <b>idev -N 2 -n 8 -p v100</b></pre>

		1. Load TensorFlow 2.1.0

			<pre class="cmd-line">
			c001-006$ <b>module load tensorflow-py3/2.1.0</b></pre>

		1. Download and checkout benchmarks compatible with TF 2.1

			<pre class="cmd-line">
			(py3_powerai_1.7.0) c001-006$ <b>git clone --branch cnn_tf_v2.1_compatible \
				https://github.com/tensorflow/benchmarks.git</b>
			(py3_powerai_1.7.0) c001-006$ <b>cd benchmarks</b></pre>
	
		1. Run using eight GPUs using ibrun and Horovod:

			<pre class="cmd-line">
			(py3_powerai_1.7.0) c001-006$ <b>ibrun -n 8 python scripts/tf_cnn_benchmarks/tf_cnn_benchmarks.py \
				--num_gpus=1 --model resnet50 --batch_size 32 --num_batches 100 --variable_update=horovod</b>
			TACC:  Starting up job 22832
			TACC:  Setting up parallel environment for OpenMPI mpirun.
			TACC:  Starting parallel tasks...
			&hellip;
			----------------------------------------------------------------
			total images/sec: 2560.04
			----------------------------------------------------------------
			TACC:  Shutdown complete. Exiting.</pre>
		
#faq
	:markdown
		# [FAQ](#faq)

		Q: **I have missing Python packages when using TensorFlow. What shall I do?**  

		A: Deep learning frameworks usually depend on many other packages. e.g., the [Caffe package dependency list](https://github.com/intel/caffe/blob/master/python/requirements.txt). On TACC resources, you can install these packages in user space by running:

		<pre class="cmd-line">$ <b>pip install --user <i>package-name</i></b></pre>

#refs
	:markdown
		# [References](#refs)

		* [Software at TACC](https://portal.tacc.utexas.edu/software)
		* [Maverick2 User Guide](https://portal.tacc.utexas.edu/user-guides/maverick2)
		* [Caffe on Stampede2](https://portal.tacc.utexas.edu/software/caffe)
		* [Github: TensorFlow](https://github.com/tensorflow/tensorflow)
		* [Stampede2 User Guide](https://portal.tacc.utexas.edu/user-guides/stampede2)



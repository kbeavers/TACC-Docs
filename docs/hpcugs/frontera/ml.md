## [Machine Learning on Frontera](#ml) { #ml }

Frontera is well equipped to provide researchers with the latest in Machine Learning frameworks, PyTorch and Tensorflow. We recommend using the Python virtual environment to manage machine learning packages.

### [Running PyTorch ](#ml-pytorch) { #ml-pytorch }

1. Request a single compute node in Frontera's `rtx-dev` queue using the [`idev`](https://portal.tacc.utexas.edu/software/idev) utility:

	<pre class="cmd-line">login2.frontera$ <b>idev -N 1 -n 1 -p rtx-dev -t 02:00:00</b></pre>

1. Create a Python virtual environment

	<pre class="cmd-line">c123-456$ <b>python3 -m venv /path/to/virtual-env</b>  # (e.g., $SCRATCH/python-envs/test)</pre>

1. Activate the Python virtual environment

	<pre class="cmd-line">c123-456$ <b>source /path/to/virtual-env/bin/activate</b></pre>

1. Install PyTorch 

	<pre class="cmd-line">c123-456$ <b>pip3 install torch torchvision torchaudio --extra-index-url https://download.pytorch.org/whl/cu113</b></pre>

#### [Single-Node](#ml-pytorch-single) { #ml-pytorch-single }

1. Download the benchmark:

	<pre class="cmd-line">
	c123-456$ <b>cd $SCRATCH</b>
	c123-456$ <b>git clone https://github.com/gpauloski/kfac-pytorch.git</b>
	c123-456$ <b>cd kfac-pytorch</b>
	c123-456$ <b>git checkout tags/v0.3.2</b>
	c123-456$ <b>pip3 install -e .</b>
	c123-456$ <b>pip3 install torchinfo tqdm Pillow</b>
	c123-456$ <b>export LD_LIBRARY_PATH=/usr/lib64:$LD_LIBRARY_PATH</b></pre>

1. Run the benchmark on one node (4 GPUs):

	<pre class="cmd-line">c123-456$ <b>python3 -m torch.distributed.launch --nproc_per_node=4 examples/torch_cifar10_resnet.py --kfac-update-freq 0</b></pre>

#### [Multi-Node](#ml-pytorch-multi) { #ml-pytorch-multi }

1. Request two nodes in the `rtx-dev` queue using the [`idev`](https://portal.tacc.utexas.edu/software/idev) utility:

	<pre class="cmd-line">login2.frontera$ <b>idev -N 2 -n 2 -p rtx-dev -t 02:00:00</b></pre>

1. Go to the benchmark directory:

	<pre class="cmd-line">c123-456$ <b>cd $SCRATCH/kfac-pytorch</b></pre>

1. Create a script called "`run.sh`". This script needs two parameters, the hostname of the master node and the number of nodes.

	<pre class="job-script">
	&#35;!/bin/bash

	HOST=$1
	NODES=$2
	LOCAL_RANK=${PMI_RANK}

	python3 -m torch.distributed.launch --nproc_per_node=4 --nnodes=$NODES --node_rank=${LOCAL_RANK} --master_addr=$HOST \
	   examples/torch_cifar10_resnet.py --kfac-update-freq 0</pre>


1. Run multi-gpu training:
	
	<pre class="cmd-line">c123-456$ <b>ibrun -np 2 ./run.sh c123-456 2</b></pre>


### [Running Tensorflow ](#ml-tensorflow) { #ml-tensorflow }

Follow these instructions to install and run TensorFlow benchmarks on Frontera RTX. Frontera RTX runs TensorFlow 2.8.0 with Python 3.8.2. Frontera supports CUDA/10.1, CUDA/11.0, and CUDA/11.1. By default, we use CUDA/11.3. Select the appropriate CUDA version for your TensorFlow version.

1. Request a single compute node in Frontera's `rtx-dev` queue using the [`idev`](https://portal.tacc.utexas.edu/software/idev) utility:

	<pre class="cmd-line">login2.frontera$ <b>idev -N 1 -n 1 -p rtx-dev -t 02:00:00</b></pre>

1. Create a Python virtual environment:

	<pre class="cmd-line">c123-456$ <b>python3 -m venv /path/to/virtual-env</b> # e.g., $SCRATCH/python-envs/test</pre>

1. Activate the Python virtual environment:

	<pre class="cmd-line">c123-456$ <b>source /path/to/virtual-env/bin/activate</b></pre>

1. Install TensorFlow and Horovod

	<pre class="cmd-line">
	c123-456$ <b>module load cuda/11.3 cudnn nccl</b>
	c123-456$ <b>pip3 install tensorflow-gpu==2.8.2</b></pre>

	We suggest installing Horovod version 0.25.0. If you wish to install other versions of Horovod, please submit a support ticket with the subject "Request for Horovod" and TACC staff will provide special instructions.

	<pre class="cmd-line">c123-456$ <b>HOROVOD_CUDA_HOME=$TACC_CUDA_DIR HOROVOD_NCCL_HOME=$TACC_NCCL_DIR CC=gcc \
    	HOROVOD_GPU_ALLREDUCE=NCCL HOROVOD_GPU_BROADCAST=NCCL HOROVOD_WITH_TENSORFLOW=1 pip3 install horovod==0.25.0</b></pre>

#### [Single-Node](#ml-tensorflow-single) { ml-tensorflow-single }

1. Download the tensorflow benchmark to your $SCRATCH directory, then check out the branch that matches your tensorflow version.

	<pre class="cmd-line">
	c123-456$ <b>cds; git clone https://github.com/tensorflow/benchmarks.git</b>
	c123-456$ <b>cd benchmarks</b> 
	c123-456$ <b>git checkout 51d647f</b>     # master head as of 08/18/2022</pre>

1. Activate the Python virtual environment

	<pre class="cmd-line">c123-456$ <b>source /path/to/virtual-env/bin/activate</b></pre>

1. Benchmark the performance with synthetic dataset on 1 GPU

	<pre class="cmd-line">
	c123-456$ <b>cd scripts/tf_cnn_benchmarks</b>
	c123-456$ <b>python3 tf_cnn_benchmarks.py --num_gpus=1 --model resnet50 --batch_size 32 --num_batches 200</b></pre>

1. Benchmark the performance with synthetic dataset on 4 GPUs

<pre class="cmd-line">
c123-456$ <b>cd scripts/tf_cnn_benchmarks</b>
c123-456$ <b>ibrun -np 4 python3 tf_cnn_benchmarks.py --variable_update=horovod --num_gpus=1 \
    --model resnet50 --batch_size 32 --num_batches 200 --allow_growth=True</b></pre>

#### [Multi-Node](#ml-tensorflow-multi) { #ml-tensorflow-multi }

*Coming Soon*

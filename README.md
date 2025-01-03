# Flexible Motion In-betweening with Diffusion Models

[![arXiv](https://img.shields.io/badge/arXiv-<2305.12577>-<COLOR>.svg)](https://arxiv.org/abs/2405.11126)

The official PyTorch implementation of the paper [**"Flexible Motion In-betweening with Diffusion Models"**](https://arxiv.org/pdf/2405.11126).

For more details, visit our [**project page**](https://setarehc.github.io/CondMDI/).

![teaser](./assets/teaser.png)

## News
📢
**21/June/24** - First release.


### Bibtex
If you find this code useful in your research, please cite:

```
@article{cohan2024flexible,
  title={Flexible Motion In-betweening with Diffusion Models},
  author={Cohan, Setareh and Tevet, Guy and Reda, Daniele and Peng, Xue Bin and van de Panne, Michiel},
  journal={arXiv preprint arXiv:2405.11126},
  year={2024}
}
```


## Getting started

This code was developed on `Ubuntu 20.04 LTS` with Python 3.7, CUDA 11.7 and PyTorch 1.13.1.


### 1. Setup environment
Install ffmpeg (if not already installed):

```shell
sudo apt update
sudo apt install ffmpeg
```
For windows use [this](https://www.geeksforgeeks.org/how-to-install-ffmpeg-on-windows/) instead.


### 2. Install dependencies
This codebase shares a large part of its base dependencies with [GMD](https://github.com/korrawe/guided-motion-diffusion). We recommend installing our dependencies from scratch to avoid version differences.

Setup virtual env:
```shell
python3 -m venv .env_condmdi
source .env_condmdi/bin/activate
pip uninstall ffmpeg
pip install spacy
pip install -r requirements.txt
pip install git+https://github.com/mattloper/chumpy
python -m spacy download en_core_web_sm
pip install git+https://github.com/openai/CLIP.git
```

Download dependencies:

<details>
  <summary><b>Text to Motion</b></summary>

```bash
bash prepare/download_smpl_files.sh
bash prepare/download_glove.sh
bash prepare/download_t2m_evaluators.sh
```
</details>

<details>
  <summary><b>Unconstrained</b></summary>

```bash
bash prepare/download_smpl_files.sh
bash prepare/download_t2m_evaluators.sh
bash prepare/download_recognition_unconstrained_models.sh
```


</details>

Prepare wandb:
This code uses wandb to log the training process. You can either create an account on wandb and use your own API key or use the default one provided in \prepare\wandb.py

```bash
export WANDB_ENTITY="adityakv0212-indian-institute-of-technology-kanpur"
export WANDB_PROJECT="diffusion_model"
export WANDB_API_KEY="b4bef5407081c044c8d828f8e9686a127fcae5ea"

```

### 2. Get data
There are two paths to get the data:

(a) **Generation only** wtih pretrained text-to-motion model without training or evaluating

(b) **Get full data** to train and evaluate the model.


#### a. Generation only (text only)

**HumanML3D** - Clone HumanML3D, then copy the data dir to our repository:

```shell
cd ..
git clone https://github.com/EricGuo5513/HumanML3D.git
unzip ./HumanML3D/HumanML3D/texts.zip -d ./HumanML3D/HumanML3D/
cp -r HumanML3D/HumanML3D diffusion-motion-inbetweening/dataset/HumanML3D
cd diffusion-motion-inbetweening
cp -a dataset/HumanML3D_abs/. dataset/HumanML3D/
```


#### b. Full data (text + motion capture)

```bash
bash prepare/download_humanml3d.sh
```

## Training

Our model is trained on the **HumanML3D** dataset.
### Conditional Model
```shell
python -m train.train_condmdi --keyframe_conditioned
```
* You can ramove `--keyframe_conditioned` to train a unconditioned model.
* Use `--device` to define GPU id.

## Evaluate
All evaluation are done on the HumanML3D dataset.

### Text to Motion - <u>With</u> keyframe conditioning

* For each prompt, 5 keyframes are sampled from the ground truth motion. The ground locations of the root joint in those frames are used as conditions.

#### on the unconditioned model
```shell
python -m eval.eval_humanml_condmdi --model_path ./save/condmdi_uncond/model000500000.pt --edit_mode gmd_keyframes --imputate --stop_imputation_at 1
```
* Above prompt evaluates the inference-time imputation for keyframe conditioning.

#### on the conditional model
```shell
python -m eval.eval_humanml_condmdi --model_path ./save/condmdi_randomframes/model000750000.pt --edit_mode gmd_keyframes --keyframe_guidance_param 1.
```



## Motion Synthesis
<details>
  <summary><b>Text to Motion - <u>Without</u> spatial conditioning</b></summary>

This part is a standard text-to-motion generation.

### Generate from test set prompts
#### using the unconditioned model
```shell
python -m sample.synthesize --model_path ./save/condmdi_uncond/model000500000.pt --num_samples 10 --num_repetitions 3
```
#### using the conditional model
```shell
python -m sample.conditional_synthesis --model_path ./save/condmdi_randomframes/model000750000.pt --edit_mode uncond --num_samples 10 --num_repetitions 3
```
* You can use `--no_text` to sample from the conditional model without text conditioning.
* Change the name of the model with your current model to generate the motion.
### Generate from a single prompt
#### using the unconditioned model
```shell
python -m sample.synthesize --model_path ./save/condmdi_uncond/model000500000.pt --num_samples 10 --num_repetitions 1 --text_prompt "a person is exercising and jumping"
```
#### using the conditional model
```shell
python -m sample.conditional_synthesis --model_path ./save/condmdi_randomframes/model000750000.pt --edit_mode uncond --num_samples 10 --num_repetitions 3 --text_prompt "a person is exercising and jumping"
```
![example](assets/example_text_only.gif)
</details>

<details>
  <summary><b>Text to Motion - <u>With</u> keyframe conditioning</b></summary>

### Generate from a single prompt - condition on keyframe locations
#### using the uncoditioned model
```shell
python -m sample.edit --model_path ./save/condmdi_uncond/model000500000.pt --edit_mode benchmark_sparse --transition_length 5 --num_samples 10 --num_repetitions 3 --imputate --stop_imputation_at 1 --reconstruction_guidance --reconstruction_weight 20 --text_condition "a person throws a ball"
```
* You can remove `--text_condition` to generate samples conditioned only on keyframes (not text).
#### using the conditional model
```shell
python -m sample.conditional_synthesis --model_path ./save/condmdi_randomframes/model000750000.pt --edit_mode benchmark_sparse --transition_length 5 --num_samples 10 --num_repetitions 3 --text_prompt "a person throws a ball"
```

### Generate from test set prompts - condition on keyframe locations
#### using the conditional model
```shell
python -m sample.conditional_synthesis --model_path ./save/condmdi_randomframes/model000750000.pt --edit_mode benchmark_sparse --transition_length 5 --num_samples 10 --num_repetitions 3
```
* You can use `--no_text` to sample from the conditional model without text conditioning.

(In development) Using the `--interactive` flag will start an interactive window that allows you to choose the keyframes yourself. The interactive pattern will override the predefined pattern.
![example](assets/example_conditional_sparse_T=5.gif)


**Useful flags for spatial conditioning:**
* `--edit_mode` to indicate the type of spatial condition.
* `--imputation` to use imputation/inpainting for inference-time conditioning.
    * `stop_imputation_at` to indicate the diffusion step to stop replacement. Default is 0.
* `--reconstruction_guidance` to use reconstruction guidance for inference-time conditioning.
    * `--reconstruction_weight` to indicate the reconstruction guidance weight ($w_r$ in Algorithm 3)
</details>

**You may also define:**
* `--device` id.
* `--seed` to sample different prompts.
* `--motion_length` (text-to-motion only) in seconds (maximum is 9.8[sec]).
* `--progress` to save the denosing progress.

**Running those will get you:**
* `results.npy` file with text prompts and xyz positions of the generated animation
* `sample##_rep##.mp4` - a stick figure animation for each generated motion.
You can stop here, or render the SMPL mesh using the following script.

### Render SMPL mesh

To create SMPL mesh per frame run:

```shell
python -m visualize.render_mesh --input_path /path/to/mp4/stick/figure/file
```

**This script outputs:**
* `sample##_rep##_smpl_params.npy` - SMPL parameters (thetas, root translations, vertices and faces)
* `sample##_rep##_obj` - Mesh per frame in `.obj` format.

**Notes:**
* The `.obj` can be integrated into Blender/Maya/3DS-MAX and rendered using them.
* This script is running [SMPLify](https://smplify.is.tue.mpg.de/) and needs GPU as well (can be specified with the `--device` flag).
* **Important** - Do not change the original `.mp4` path before running the script.

**Notes for 3d makers:**
* You have two ways to animate the sequence:
  1. Use the [SMPL add-on](https://smpl.is.tue.mpg.de/index.html) and the theta parameters saved to `sample##_rep##_smpl_params.npy` (we always use beta=0 and the gender-neutral model).
  1. A more straightforward way is using the mesh data itself. All meshes have the same topology (SMPL), so you just need to keyframe vertex locations.
     Since the OBJs are not preserving vertices order, we also save this data to the `sample##_rep##_smpl_params.npy` file for your convenience.

### My Contribution

I have added the Gaussian Sampling for the keyframes to filter the data related to swimming and skatting that was leading to jitter and sliding in the generated motion. 
I first score the data based on how much closer it is to the swimming and skatting motion and then sample the keyframes based on the gaussian distribution of the scores.
To run the code with the gaussian sampling, use the following command:

```shell
python ./preprocess/scoring.py
python ./preprocess/sampling.py
```

This samples the data and stores it in the dataset/HumanML3D folder. Now we can continue with the training and evaluation of the model.

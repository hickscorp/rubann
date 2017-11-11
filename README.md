# An Introduction to Ruby and ANNs

## Introduction

- What is Ruby?
- Why Ruby?
- What is a CPU?
- What is a GPU?
- Name one thing that would run better on a CPU vs a GPU, and the other way around.

- What's an ANN?
- Explain the choice of `libfann`.
- Why don't we build it ourself?

## Preparation

First off, install all the native libraries that we will use through Ruby.

```bash
sudo apt-get install libfann2 libfann-dev
```

Then, make sure the files are here by listing the content of `/usr/include/fann*`
and making sure there are results there.

Then, try and load `libfann` using Ruby:

```
require 'ruby-fann'
train = RubyFann::TrainData.new(:inputs=>[[0.3, 0.4, 0.5], [0.1, 0.2, 0.3]], :desired_outputs=>[[0.7], [0.8]])
fann = RubyFann::Standard.new(:num_inputs=>3, :hidden_neurons=>[2, 8, 4, 3, 4], :num_outputs=>1)
fann.train_on_data(train, 1000, 10, 0.1) # 1000 max_epochs, 10 errors between reports and 0.1 desired MSE (mean-squared-error)
outputs = fann.run([0.3, 0.2, 0.4])
```

library(keras)
model <- keras_model_sequential() %>%
  layer_dense(units = 32, activation = "relu", input_shape = c(784)) %>%
  layer_dense(units = 10, activation = "softmax")
mnist <- dataset_mnist()
x_train <- mnist$train$x
y_train <- mnist$train$y
x_test <- mnist$test$x
y_test <- mnist$test$y

input_tensor <- layer_input(shape = c(784))
output_tensor <- input_tensor %>%
  layer_dense(units = 32, activation = "relu") %>%
  layer_dense(units = 10, activation = "softmax")
model <- keras_model(inputs = input_tensor, outputs = output_tensor)
model %>% compile(
  loss = 'categorical_crossentropy',
  optimizer = optimizer_rmsprop(),
  metrics = c('accuracy') # monitor performance
)
his <- model %>% fit(
  x_train, y_train,
  epochs = 30, batch_size = 128, # epochs: number of passes through the full training set
  validation_split = 0.2 # 20% from _train used for validation
)
mnist <- keras::dataset_mnist()
library(reticulate)
np <- import("numpy")
dataset_zip <- np$load("/users/viralpandey/Desktop/Summer\ Full\ 2019/DS\ 7290\ Causal\ ML/Project/CausalVAE/dsprites-dataset/dsprites_ndarray_co1sh3sc6or40x32y32_64x64.npz")

#print(data['latents_values'])

#imgs <- dataset_zip['imgs']
latents_values <- dataset_zip['latents_values']
latents_classes <- dataset_zip['latents_classes']
metadata <- dataset_zip['metadata']

latents_sizes <- metadata['latents_sizes']
#latents_bases <- np.concatenate((latents_sizes[::-1].cumprod()[::-1][1:],
#                                np.array([1,])))

library(grid)
library(Rgraphviz)
library(bnlearn)
dag <- empty.graph(nodes = c("shape","orientation","scale","X","Y","image"))
arc.set <- matrix(c("shape", "orientation",
                    "shape", "scale",
                    "shape", "image",
                    "orientation", "X",
                    "orientation", "image",
                    "X", "image",
                    "scale", "image", 
                    "scale", "Y",
                    "Y", "image"),
                  byrow = TRUE, ncol = 2,
                  dimnames = list(NULL, c("from", "to")))
arcs(dag) <- arc.set

graphviz.plot(dag, layout = "dot")


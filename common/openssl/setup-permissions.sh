kubectl create rolebinding rob-read-default --clusterrole=view --user=rob --namespace=default
kubectl create rolebinding rob-read-flux-system --clusterrole=view --user=rob --namespace=flux-system
kubectl create rolebinding rob-read-kube-system --clusterrole=view --user=rob --namespace=kube-system
kubectl create rolebinding rob-read-ndtech --clusterrole=view --user=rob --namespace=ndtech
kubectl create rolebinding rob-edit-rob --clusterrole=edit --user=rob --namespace=rob
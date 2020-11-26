# install istio
cd /root
mkdir istio
cd istio
export ISTIO_VERSION=1.6.8
curl -L https://git.io/getLatestIstio | ISTIO_VERSION=${ISTIO_VERSION} sh -
cd istio-${ISTIO_VERSION}
export PATH=${PWD}/bin:$PATH
istioctl install --set profile=demo
kubectl label namespace default istio-injection=enabled
echo "after install istio"

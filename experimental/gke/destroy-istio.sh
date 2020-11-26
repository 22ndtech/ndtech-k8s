# destroy istio only
echo "destroying istio"
cd "${CONTEXT_PATH}
mkdir istio
cd istio
export ISTIO_VERSION=1.6.8
curl -L https://git.io/getLatestIstio | ISTIO_VERSION=${ISTIO_VERSION} sh -
cd istio-${ISTIO_VERSION}
export PATH=${PWD}/bin:$PATH
istioctl manifest generate --set profile=demo | kubectl delete -f -
kubectl delete namespace istio-system

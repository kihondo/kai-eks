### Deploy echo-1 and echo-2 services
```
$ k apply -f k8s-services/echo-1.yaml
service/echo-1 created
serviceaccount/echo-1 created
deployment.apps/echo-1 created

$ k apply -f k8s-services/echo-2.yaml
service/echo-2 created
serviceaccount/echo-2 created
deployment.apps/echo-2 created
```
```
$ k get svc
NAME         TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)    AGE
echo-1       ClusterIP   172.20.161.209   <none>        8080/TCP   43s
echo-2       ClusterIP   172.20.146.238   <none>        8080/TCP   43s
kubernetes   ClusterIP   172.20.0.1       <none>        443/TCP    20m
```

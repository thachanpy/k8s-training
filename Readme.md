# Outline Training K8s - CKA

## 1. Tìm hiểu về Docker.

- ### Docker là gì?
- ### Kiến trúc của Docker - containerd (container)

## 2. Tìm hiểu về K8s core concert

- ### K8s là gì?
- ### Setup k8s - Local (1 master + 1 worker - > 2GB RAM - >2CPU) - Virtualbox (Ubuntu).
- ### Kiến trúc của k8s
  - #### Etcd
  - #### Kube-API server
  - #### Kube Controller Manager
  - #### Kube Scheduler
  - #### Kubelet
  - #### Kube-proxy
  - #### Container Runtime
- ### Kubectl
- ### Namespaces
- ### Pods
- ### ReplicaSets
- ### Deployments
- ### Services
  - #### ClusterIP
  - #### NodePort
  - #### LoadBalancer

## 3. Tìm hiểu về Scheduling

- ### Labels và Pod Selectors
- ### Taint and Tolerations
- ### Node Selectors
- ### Node Affinity
- ### Resource and Limit
- ### Static Pods
- ### Multiple Scheduler
- ### DaemonSets

## 4. Tìm hiểu về Application Lifecycle Mangement

- ### Rolling update
- ### Rollback
- ### Config Map
- ### Secret
- ### Multi Container
- ### Init Container

## 5. Logging and Monitoring

- ### Metric Server
- ### Application Logs

## 6. Cluster Management

- ### Upgrade
- ### Backup and Restore

## 7. Security

- ### Authentication
- ### TLS
- ### Certificate API
- ### KubeConfig
- ### API Group
- ### RBAC - Role + RoleBinding + ClusterRole + ClusterRoleBinding
- ### ServiceAccount
- ### Security Contexts

## 8. Network

- ### DNS + CoreDNS
- ### Cluster Networking
- ### Pod Networking
- ### CNI
- ### Ingress + Ingress Controller
- ### NetworkPolicy

## 9. Storage

- ### ontainer Storage Interface
- ### Persistent Volumes
- ### Persistent Volumes Claims
- ### Storage Class

## 10. Bài tập cuối khóa + Kinh nghiệm thi CKA

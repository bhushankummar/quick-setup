## Kubernetes requires at least 2 to be available

#### Install Kubernet
```
curl -LO "https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl"
```

#### Set Permission for Current User
```
chmod +x ./kubectl
ls -ltrh
```

#### For Ubuntu
```
sudo mv ./kubectl /usr/local/bin/kubectl
```

#### For MAC
```
sudo mv ./kubectl /usr/local/bin/kubectl
```

#### Verify Installation
```
kubectl version --client
```

### Add new User
```
adduser developer
# password@7
usermod -aG sudo developer
```

### Login to the newly created User
```
su - developer
# password@7
```

### Add User to the Docker Group
```
sudo groupadd docker
sudo usermod -aG docker $USER
- Re-Login or Restart the Server
```

#### Install Minicube
```
curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
chmod +x minikube
mv ./minikube /usr/local/bin/minikube
```

#### Start minikube with Docker Driver
```
minikube start --driver=docker
``` 

#### Verify minikube Installation
```
docker ps
```

#### Remove Minicube
```
docker rm -f kind-control-plane
rm /usr/local/bin/kind
```

#### References
- Post-installation steps for Linux
```
https://docs.docker.com/engine/install/linux-postinstall/
```

- Minicube
```
https://kubernetes.io/docs/setup/learning-environment/minikube/#starting-a-cluster
https://minikube.sigs.k8s.io/docs/drivers/docker/
```
# Steps to upgrade Kubernetes control plane node :

# Setting up (Changing)  apt repository:

curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.32/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.32/deb/ /' | \
	sudo tee /etc/apt/sources.list.d/kubernetes.list




# Upgrading kubeadm ,kubelet and kubectl (Execute commands as root user or with sudo)
      
apt-mark unhold kubeadm kubectl kubelet
apt-get update   
apt --fix-broken install
apt-get install -y kubeadm=1.32.4-1.1 kubectl=1.32.4-1.1 kubelet=1.32.4-1.1  #If it fails , execute apt --fix-broken install 
apt list -a kubeadm   # To check available versions
apt-mark hold kubeadm kubectl kubelet
       
kubeadm upgrade plan
kubeadm upgrade apply v1.32.4 -y
kubeadm version


# Restart kubelet :

systemctl restart kubelet
systemctl status kubelet  #To check status after restart

# Verify version: 

# kubectl get nodes


# In case of HA setup (e.g., 3 control plane nodes ), repeat all steps for other control plane nodes and execute command

# kubeadm upgrade node instead of kubeadm upgrade apply command.

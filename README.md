# 🚀 CV Automation with Airflow (Astro) & Docker

## 📌 Project Overview
This project was created as a personal challenge. My CV was written in .docx but I recently decided to migrate to .tex to make it more customizable.
LaTeX files can be easily manipulated with online platforms such as Overleaf, but I decided to develop everything locally and to make a ETL that updates everything.
The project automates the process of **compiling a LaTeX (`.tex`) file into a PDF** using **Apache Airflow** and **Docker**.
It continuously monitors changes in a `.tex` file (My CV) and, when detected:
1. **Compiles it into a PDF** using a Docker container.
2. **Uploads the generated PDF** to a GitHub repository.
3. **Resets the workflow** to monitor future updates.
By doing this, with a simple command (astro dev start) the workflow monitors any changes to the .tex file and updates a dedicated github repository with the last version of my CV.

## 🎯 Goal of This Project
- **Automate LaTeX compilation** without manual intervention.
- **Make the process reproducible** using Docker & Airflow.
- **Easily access to the last version of my CV** by uploading them to GitHub.
---

## 🛠️ Installation & Setup

### **🔹 Prerequisites**
You can try for yourself, if you already have a .tex CV (if you don't, python libraries like pandoc can convert from almost every file format to .tex), make sure you have installed:
- **Docker**: [Install Docker](https://docs.docker.com/get-docker/)
- **Docker Compose**: [Install Docker Compose](https://docs.docker.com/compose/install/)
- **GitHub Personal Access Token** [https://www.geeksforgeeks.org/how-to-generate-personal-access-token-in-github/] with "Contents" permission
- **Basic LaTeX knowledge** (if you plan to modify the `.tex` file)
- **Astro CLI** [https://www.astronomer.io/docs/astro/cli/install-cli/] to start the project

### **🔹 1️⃣ Clone This Repository**
```bash
git clone https://github.com/marcelo-martins/cv.git
cd cv/
```

### **🔹 2️⃣ Set Up Environment Variables**
Rename the .envexample file in the project root to `.env` and adapt the variables

### **🔹 3️⃣ Build and Start the Project**
```bash
astro dev start
```

### **🔹 4️⃣ Access Airflow Web UI**
After starting the project, access the **Airflow UI**:
```bash
http://localhost:8080
```
- Username: **admin**
- Password: **admin**

---

## 🚀 Usage Guide

### **🔹 Start the latex_compiler DAG manually to keep it running**

### **🔹 Modifying the LaTeX File**
- Edit the `.tex` file inside `latex/input/`.
- The **Airflow DAG automatically detects the change** and triggers the compilation.

### **🔹 Checking DAG Status**
- Open **Airflow Web UI (`http://localhost:8080`)**.
- Navigate to the **"latex_compilation" DAG**.
- Click on "Graph View" to monitor tasks.

### **🔹 Accessing the Generated PDF**
- If configured, it will also be pushed to your GitHub repository.

### **🔹 Stopping the Project**
After 10 minutes without modifications, the DAG stops
You can also run
```bash 
astro dev stop
```

---

## 🔧 Troubleshooting

### **1️⃣ Airflow Not Detecting Changes**
- Ensure volume mounts are correctly configured:
  ```yaml
  volumes:
    - ./latex/input:/usr/local/airflow/latex/input
  ```
- Restart Airflow:
  ```bash
  docker-compose restart airflow
  ```

### **2️⃣ GitHub Upload Failing**
- Check if your **Personal Access Token (PAT)** has the correct permissions (`repo` scope).
- Verify the **GitHub repository URL** in `.env`.

### **3️⃣ Docker Inside the Container Not Working**
- Make sure you're running with `privileged: true` in `docker-compose.yml`:
  ```yaml
  privileged: true
  ```

---

## 📜 License
This project is licensed under the **MIT License**.

## 🤝 Contributing
Feel free to submit **pull requests** or **open issues** if you have improvements or feature requests!

## 📩 Contact
For questions or collaborations, reach out via:
📧 Email: [marcelobmartins219@hotmail.com](mailto:marcelobmartins219@hotmail.com)  
🔗 LinkedIn: [Your LinkedIn Profile](https://www.linkedin.com/in/your-profile)  


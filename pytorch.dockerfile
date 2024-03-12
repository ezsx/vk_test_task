FROM pytorch/pytorch:latest

# Установка дополнительных зависимостей, если они необходимы
RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    curl \
    ca-certificates \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Копирование файла requirements и установка зависимостей Python
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Копирование остальных файлов проекта
COPY . /workspace

# Установка рабочего каталога
WORKDIR /workspace

# Открытие порта для Jupyter Notebook
EXPOSE 8888

# Запуск Jupyter Notebook
CMD ["jupyter", "notebook", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root", "--NotebookApp.token=''", "--NotebookApp.password=''"]

# startup command
# docker build -t pytorch-jupyter -f pytorch.dockerfile .
# docker run --rm -it --gpus all -p 8888:8888 -v ${PWD}:/workspace pytorch-jupyter
# docker run --rm -it --gpus all -p 8888:8888 -v C:\py_proj\vk_test_task:/workspace pytorch-jupyter
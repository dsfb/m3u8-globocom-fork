# 1. Specify the official lightweight base image
FROM python:3.10-slim

# 2. Set environment variables to optimize Python performance inside containers
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# 3. Set the active working directory inside the container
WORKDIR /app

# 4. Install system level dependencies (Optional: only needed for packages like psycopg2 or cryptography)
# RUN apt-get update && \
#    DEBIAN_FRONTEND=noninteractive TZ=Etc/UTC apt-get install -y tzdata && \
#     apt-get install -y --no-install-recommends \
#     build-essential \
#     && rm -rf /var/lib/apt/lists/*

# 5. Copy and install dependencies first to leverage Docker layer caching
COPY requirements.txt .
COPY requirements-dev.txt .
RUN pip install --no-cache-dir -r requirements-dev.txt

# 6. Copy the rest of your application code
COPY . .

# 7. Expose the port your app runs on (e.g., 8000 for web apps)
# EXPOSE 8000

# 8. Define the default command to start your application
# CMD ["python", "main.py"]
CMD ["./runtests", ]

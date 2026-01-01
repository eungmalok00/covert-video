# ប្រើ Python 3.10
FROM python:3.10-slim

# ដំឡើង FFmpeg (នេះជាមូលហេតុដែល Localhost ដើរតែ Server មិនដើរ)
RUN apt-get update && apt-get install -y \
    ffmpeg \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# កំណត់ Folder ការងារ
WORKDIR /app

# ចម្លងឯកសារ និងដំឡើងបណ្ណាល័យ
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# ចម្លងកូដទាំងអស់ (index.html, app.py, etc.)
COPY . .

# កំណត់ Port សម្រាប់ Website (Render ប្រើ Port 10000 តាមធម្មតា)
EXPOSE 10000

# បញ្ជាឱ្យ App ដំណើរការ
CMD ["gunicorn", "--bind", "0.0.0.0:10000", "app:app"]

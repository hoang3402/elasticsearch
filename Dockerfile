# Sử dụng image cơ bản của Ubuntu
FROM ubuntu:latest

# Cập nhật danh sách các gói và cài đặt sudo (nếu cần)
RUN apt-get update && apt-get install -y sudo

# Thêm khóa GPG và địa chỉ nguồn APT cho Elasticsearch
RUN curl -fsSL https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
RUN echo "deb https://artifacts.elastic.co/packages/7.x/apt stable main" | sudo tee -a /etc/apt/sources.list.d/elastic-7.x.list

# Cập nhật lại danh sách gói sau khi thêm nguồn mới rồi cài đặt Elasticsearch
RUN sudo apt-get update && sudo apt-get install -y elasticsearch

# Expose cổng mặc định của Elasticsearch
EXPOSE 9200 9300

# Cấu hình Elasticsearch để chấp nhận remote connections
# Thay đổi 'network.host' từ 'localhost' sang '0.0.0.0'
RUN echo "network.host: 0.0.0.0" >> /etc/elasticsearch/elasticsearch.yml

# Điểm vào để khởi động Elasticsearch khi container bắt đầu
ENTRYPOINT ["/usr/share/elasticsearch/bin/elasticsearch"]

# Các thông số mặc định khi khởi động
CMD ["-Enode.name=Node01", "-Ediscovery.type=single-node"]

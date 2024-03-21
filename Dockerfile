# Sử dụng image cơ bản của Ubuntu và cài đặt các công cụ cần thiết
FROM ubuntu:latest

# Cập nhật danh sách gói và cài đặt curl và gnupg cần thiết để thêm khóa GPG
RUN apt-get update && \
    apt-get install -y curl gnupg && \
    curl -fsSL https://artifacts.elastic.co/GPG-KEY-elasticsearch | apt-key add - && \
    echo "deb https://artifacts.elastic.co/packages/7.x/apt stable main" | tee -a /etc/apt/sources.list.d/elastic-7.x.list && \
    apt-get update && apt-get install -y elasticsearch

# Tạo người dùng không phải là root để chạy Elasticsearch
RUN groupadd elasticsearch && \
    useradd -g elasticsearch -m elasticsearch

# Đổi chủ sở hữu của các thư mục cần thiết
RUN chown -R elasticsearch:elasticsearch /usr/share/elasticsearch/ /etc/elasticsearch

USER elasticsearch

# Expose cổng mặc định của Elasticsearch
EXPOSE 9200 9300

# Cấu hình Elasticsearch để chấp nhận remote connections
# Thay đổi 'network.host' từ 'localhost' sang '0.0.0.0'
RUN echo "network.host: 0.0.0.0" >> /etc/elasticsearch/elasticsearch.yml

# Điểm vào để khởi động Elasticsearch khi container bắt đầu
ENTRYPOINT ["/usr/share/elasticsearch/bin/elasticsearch"]

# Các thông số mặc định khi khởi động
CMD ["-Enode.name=Node01", "-Ediscovery.type=single-node"]

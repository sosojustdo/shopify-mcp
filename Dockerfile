FROM node:lts-alpine

RUN apk add --no-cache nginx supervisor

WORKDIR /app

# Copy package files
COPY package.json package-lock.json ./

# Install dependencies (ignoring lifecycle scripts to speed up build if needed)
RUN npm install --ignore-scripts

# Copy rest of the source code
COPY . .

# Build the project
RUN npm run build

# Copy nginx.conf and supervisord.conf files
COPY nginx.conf /etc/nginx/nginx.conf
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Expose nginx port
EXPOSE 80

# Start the MCP server
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]

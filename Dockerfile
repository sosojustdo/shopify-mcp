FROM node:lts-alpine

WORKDIR /app

# Copy package files
COPY package.json package-lock.json ./

# Install dependencies (ignoring lifecycle scripts to speed up build if needed)
RUN npm install --ignore-scripts

# Copy rest of the source code
COPY . .

# Build the project
RUN npm run build

# Expose a port if needed (not strictly required for CLI tool, but in case)
# EXPOSE 3000

# Start the MCP server
CMD [ "npm", "run", "sse" ]

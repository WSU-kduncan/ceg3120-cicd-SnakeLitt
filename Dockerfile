# Stage 1: Build the Angular application
FROM node:18-bullseye AS builder
LABEL stage=builder

# Set the working directory inside the container
WORKDIR /app

# Copy package.json and package-lock.json (or yarn.lock)
COPY angular-site/package*.json ./
# If you use yarn:
# COPY angular-site/yarn.lock ./

# Install dependencies using npm ci for faster, more reliable builds
RUN npm ci
# If you use yarn:
# RUN yarn install --frozen-lockfile

# Copy the rest of the application source code
COPY angular-site/. .

# Build the application for production
# Note: Replace 'angular-site' below if your project name in angular.json is different
RUN npx ng build --configuration production

# Stage 2: Serve the built application using a simple HTTP server
FROM node:18-bullseye

# Set the working directory for the server
WORKDIR /usr/share/nginx/html
# A common alternative is /app, choose what you prefer

# Install a simple http server globally
# We use 'http-server' here, 'serve' is another popular option
RUN npm install -g http-server

# Copy the built application artifacts from the builder stage
# Note: Adjust 'dist/angular-site' if your angular.json 'outputPath' is different
COPY --from=builder /app/dist/wsu-hw-ng/ .

# Expose the port the server will run on (http-server defaults to 8080)
EXPOSE 8080

# Set the default command to run the http server
# Serve files from the current directory '.' on port 8080
# '-c-1' disables caching
# '--proxy http://localhost:8080?' handles Angular routing for SPA (Single Page Application)
# Alternatively, for simpler serving without deep linking support initially: CMD [ "http-server", "-p", "8080", "." ]
CMD ["http-server", "-p", "8080", "-c-1", "--proxy", "http://localhost:8080?"]

# Optional: Run as non-root user for better security (node user is built-in)
# USER node

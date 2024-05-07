# Use an official Node.js runtime as a parent image

FROM node:16-alpine3.11

 

# Set the working directory to /app

WORKDIR /app

 

# Copy the package.json and package-lock.json files to the container

COPY package*.json ./

 

# Install dependencies

RUN npm install

 

# Copy the rest of the application code to the container

COPY . .

 

# Build the React app

RUN npm run build

 

# Serve the app with a web server

FROM nginx:1.21.0-alpine

 

# Copy Nginx configuration file

#COPY nginx.conf /etc/nginx/nginx.conf

 

# Copy built frontend code to Nginx html directory

COPY --from=0 /app/build /usr/share/nginx/html

 

# Expose Nginx port

EXPOSE 80

 

# Start Nginx with daemon off option

CMD ["nginx", "-g", "daemon off;"]

# Dockerfile
FROM docker.n8n.io/n8nio/n8n:latest

USER root
RUN npm install --global n8n-nodes-playwright
USER node

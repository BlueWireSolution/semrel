# Use Alpine Linux as the base image
FROM alpine:3.19

# Install required system dependencies
RUN apk add --no-cache \
    nodejs \
    npm \
    git

# Set working directory
WORKDIR /app

# Install semantic-release and common plugins
RUN npm install -g \
    semantic-release@22 \
    @semantic-release/commit-analyzer@11 \
    @semantic-release/release-notes-generator@12 \
    @semantic-release/changelog@6 \
    @semantic-release/npm@11 \
    @semantic-release/github@9 \
    @semantic-release/git@10

# Configure git for semantic-release
RUN git config --global user.email "semantic-release-bot@ludd.ai" && \
    git config --global user.name "Semantic Release Bot"

# Create a non-root user
RUN addgroup -S releaser && \
    adduser -S releaser -G releaser

# Switch to non-root user
USER releaser

# Set default command
CMD ["semantic-release", "--help"]
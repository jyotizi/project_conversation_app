# Project Management System

## Overview

The **Project Management System** is a modern web application designed to simplify project tracking, collaboration, and communication. Built on Ruby on Rails and styled with Tailwind CSS (with Bootstrap elements in some views), this system offers an intuitive interface for managing projects, monitoring progress, and logging conversation histories—ensuring everyone stays in sync.

## Key Features

- **User Authentication:** Secure sign-up, login, and session management powered by Devise.
- **Project Management:** Easily create, update, and track projects with standardized statuses.
- **Conversation History:** Automatically log project interactions (comments and status changes) using the `ProjectActivity`.
- **Modern Tech Stack:** Leverages Ruby 3.2.2, Rails 7.1.0, and Bootstrap for a scalable and efficient solution.

## Table of Contents

- [Technology Stack](#technology-stack)
- [Prerequisites](#prerequisites)

## Technology Stack

### Ruby

- **Ruby 3.2.2:** The programming language used in Rails development.

  - **With RVM:**
    ```bash
    curl -sSL https://get.rvm.io -o rvm.sh
    rvm install ruby-3.2.2
    ```
  - **With rbenv:**
    ```bash
    curl -fsSL https://github.com/rbenv/rbenv-installer/raw/HEAD/bin/rbenv-installer | bash
    rbenv install 3.2.2
    ```

### Rails

- **Rails 7.1.0:** The backend framework for web development.

### Database

- **PostgreSQL:** The chosen database for persistent storage.

## Prerequisites
  Needed to run the appplication on the machine:
  - ruby-3.2.2
  - rails-7.1.0
  1. Clone the repository:

  git clone https://github.com/jyotizi/project_conversation_app

  2. `cd project_conversation_app`

  3. Run `bundle install`

  5. Run `rails db:create`
  
  6. Run `rails db:migrate`
  
  7. Run `rails assets:precompile`

  9. Run `rails s`


TOML in Python – Configuration File Format
TOML stands for Tom's Obvious, Minimal Language. It is a clean, human-readable text file format used to store project settings, options, and parameters outside of your main Python code.

A TOML file always ends with the .toml file extension.

Example: config.toml or pyproject.toml

Why Do We Use TOML?
Easy to Read and Edit: Unlike JSON (which uses lots of curly braces {} and quotes) or XML (which uses heavy tags <tag>), TOML looks like a simple checklist with headers and key = value pairs.

Supports Comments: You can write # comments inside .toml files to explain what each setting does (JSON does not allow comments).

Python's Official Standard: Since Python 3.11, Python includes a built-in module called tomllib just for reading TOML files, and almost all modern Python projects use pyproject.toml to manage project builds and dependencies.

Native Data Types: TOML automatically understands strings, integers, floats, booleans (true/false), dates, and lists—so Python converts them directly into the right types without extra code.

How It Works (Step-by-Step Example)
Step 1: Create a config.toml file
Inside config.toml, you group settings using [section_headers]:

Ini, TOML
# General application settings
app_name = "UVM_Log_Parser"
debug = true

[database]
host = "localhost"
port = 5432
retries = 3

[paths]
log_dirs = ["/sim/run1", "/sim/run2"]
Step 2: Read it in Python
Depending on your Python version or your project's setup, you read it in one of two ways:

Method A: Using the third-party toml library (like in your screenshot)
First install it via terminal: pip install toml

Python
import toml

# Load the file into a Python dictionary
config_data = toml.load("config.toml")

# Access values just like a normal dictionary
print(config_data["app_name"])          # Output: UVM_Log_Parser
print(config_data["database"]["port"])  # Output: 5432
print(config_data["paths"]["log_dirs"]) # Output: ['/sim/run1', '/sim/run2']
Method B: Using Python's built-in tomllib (Python 3.11+)(Note: tomllib requires opening the file in binary read mode "rb")

Python
import tomllib

with open("config.toml", "rb") as f:
    config_data = tomllib.load(f)

print(config_data["debug"])  # Output: True
Step 3: Writing a dictionary back to a .toml file
(Only supported by third-party libraries like toml or tomli-w, not built-in tomllib)

Python
import toml

settings = {
    "simulation": {
        "timeout": 1000,
        "seed": 42
    }
}

with open("output.toml", "w") as f:
    toml.dump(settings, f)
Related Topics & Alternatives
pyproject.toml: The standard configuration file used in modern Python packaging (for tools like pip, pytest, and black).

json (JavaScript Object Notation): Another popular format for storing data and configs (config.json). Great for web APIs, but harder for humans to edit manually because it lacks comments.

yaml (YAML Ain't Markup Language): Similar to TOML (config.yaml), very common in DevOps and CI/CD pipelines, though indentation errors can easily break it.

.env files (python-dotenv): Used specifically for secret credentials (passwords, API keys) that should never be committed to Git, whereas .toml is used for general project structure and settings.

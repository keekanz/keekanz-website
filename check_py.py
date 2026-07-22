import sys
print("Python version:", sys.version)

try:
    import psd_tools
    print("psd_tools available:", psd_tools.__file__)
except ImportError:
    print("psd_tools not installed")

try:
    import PIL
    print("PIL available:", PIL.__file__)
except ImportError:
    print("PIL not installed")

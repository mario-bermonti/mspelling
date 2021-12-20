"""Console script for mspelling."""
import click

from mspelling import __version__


@click.command()
@click.version_option(version=__version__)
def main() -> int:
    """Console script for mspelling."""
    click.echo("This is the cli for the mspelling project")
    click_url = "https://click.palletsprojects.com/"
    click.echo(f"See the click docs at {click_url} for more details")
    return 0


if __name__ == "__main__":
    main()  # pragma: no cover

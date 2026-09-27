async function main(argv) {
  console.log(argv);
}

main(process.argv).catch((error) => {
  console.error("\nFatal error:", error);
  process.exit(1);
});

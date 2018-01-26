import com.xzb.showcase.base.fileconvert.util.ConvertFileUtils;
import com.xzb.showcase.base.fileconvert.util.FileConvertDto;

public class QueueTest {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
//		Thread thread = new Thread(new Runnable() {
//
//			@Override
//			public void run() {
//				for (long i = 0; i < 10; i++) {
//					ConvertFileUtils.addFile(new FileConvertDto(i, "Thread:"
//							+ Thread.currentThread().getId() + " c://test/doc"
//							+ i + ".docx", i + ""));
//				}
//			}
//		});
//
//		Thread thread2 = new Thread(new Runnable() {
//
//			@Override
//			public void run() {
//				for (long i = 0; i < 10; i++) {
//					ConvertFileUtils.addFile(new FileConvertDto(i, "Thread:"
//							+ Thread.currentThread().getId() + " c://test/doc"
//							+ i + ".docx", i + ""));
//				}
//			}
//		});
//		thread.start();
//		thread2.start();
//
//		Thread consume = new Thread(new Runnable() {
//
//			@Override
//			public void run() {
//				int index = 1;
//				while (true) {
//					try {
//						if (ConvertFileUtils.queueSize() > 0) {
//							try {
//								System.out.println("index:"
//										+ (index++)
//										+ "  "
//										+ ConvertFileUtils.takeFile()
//												.getFilePath());
//							} catch (InterruptedException e) {
//								e.printStackTrace();
//							}
//						}
//						Thread.sleep(100);
//					} catch (InterruptedException e) {
//						e.printStackTrace();
//					}
//				}
//			}
//		});
//		consume.start();
	}

}
